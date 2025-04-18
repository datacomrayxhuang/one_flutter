import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/blocs/action_todo/action_todo_bloc.dart';
import 'package:ui_elements/widgets/custom_button.dart';
import 'package:ui_elements/widgets/error_tile.dart';

/// A modal bottom sheet widget that provides actions for a specific to-do item.
///
/// The `ActionTodoModalBottomSheet` allows users to perform actions on a to-do item,
/// such as marking it as complete/incomplete or deleting it. The widget uses the
/// `ActionTodoBloc` to handle state management and displays different views based
/// on the current state.
///
/// ### Features:
/// - **Initial View**: Displays buttons for completing/incompleting or deleting the to-do.
/// - **Loading View**: Shows a loading indicator while an action is being processed.
/// - **Success View**: Displays a success message after an action is completed.
///
/// ### Usage:
/// This widget is typically shown as a modal bottom sheet using `showModalBottomSheet`.
/// It requires a `TodoModel` object to represent the to-do item.
///
/// ```dart
/// showModalBottomSheet(
///   context: context,
///   shape: const RoundedRectangleBorder(
///     borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
///   ),
///   builder: (BuildContext context) {
///     return BlocProvider<ActionTodoBloc>.value(
///       value: actionTodoBloc,
///       child: ActionTodoModalBottomSheet(todo: todo),
///     );
///   },
/// );
/// ```
///
/// ### Parameters:
/// - [todo]: The `TodoModel` object representing the to-do item for which actions are performed.
///
/// ### State Management:
/// - The widget listens to the `ActionTodoBloc` to update its UI based on the current state:
///   - `ActionTodoStateStatus.initial`: Displays the initial view with action buttons.
///   - `ActionTodoStateStatus.loading`: Displays a loading indicator.
///   - `ActionTodoStateStatus.success`: Displays a success message.
///
/// ### Lifecycle:
/// - Automatically dismisses the modal bottom sheet after 3 seconds when an action is successfully completed.
///
/// ### Dependencies:
/// - Requires `ActionTodoBloc` for state management.
/// - Uses `CustomButton` and `ErrorTile` widgets from the `ui_elements` package.
///
/// ### Example:
/// ```dart
/// ActionTodoModalBottomSheet(
///   todo: TodoModel(
///     id: '1',
///     title: 'Sample To-Do',
///     description: 'This is a sample to-do item.',
///     isCompleted: false,
///   ),
/// );
/// ```
class ActionTodoModalBottomSheet extends StatefulWidget {
  /// Creates an instance of `ActionTodoModalBottomSheet`.
  ///
  /// The [todo] parameter is required and represents the to-do item for which
  /// actions will be performed.
  const ActionTodoModalBottomSheet({
    super.key,
    required this.todo,
  });

  /// The to-do item for which actions are performed.
  final TodoModel todo;

  @override
  State<ActionTodoModalBottomSheet> createState() =>
      _ActionTodoModalBottomSheetState();
}

class _ActionTodoModalBottomSheetState
    extends State<ActionTodoModalBottomSheet> {
  /// A timer that automatically dismisses the modal bottom sheet after a
  /// specified duration.
  /// This timer is used to provide a smooth user experience by closing the
  /// modal after a successful action.
  Timer? _autoDismissTimer;

  /// On success listener for the modal bottom sheet.
  void _onSuccessAutoDismissListener(
    BuildContext context,
    ActionTodoState actionTodoState,
  ) {
    if (actionTodoState.status == ActionTodoStateStatus.success) {
      _autoDismissTimer?.cancel();
      _autoDismissTimer = Timer(
        const Duration(seconds: 3),
        () => context.pop(),
      );
    }
  }

  /// Listener for the pop invoked event.
  void _onPopInvokedCancelTimerListener(
    bool didPop,
    Object? result,
  ) {
    if (didPop) {
      _autoDismissTimer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActionTodoBloc, ActionTodoState>(
      listener: _onSuccessAutoDismissListener,
      listenWhen: (previous, current) => previous.status != current.status,
      builder: (BuildContext context, ActionTodoState actionTodoState) {
        return PopScope(
          canPop: actionTodoState.status != ActionTodoStateStatus.loading,
          onPopInvokedWithResult: _onPopInvokedCancelTimerListener,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: switch (actionTodoState.status) {
                ActionTodoStateStatus.initial =>
                  _ActionTodoModalBottomSheetInitialView(
                    todo: widget.todo,
                    errorMessage: actionTodoState.errorMessage,
                  ),
                ActionTodoStateStatus.loading =>
                  const _ActionTodoModalBottomSheetLoadingView(),
                ActionTodoStateStatus.success =>
                  _ActionTodoModalBottomSheetSuccessView(
                    actionCompletionMessage:
                        actionTodoState.actionCompletionMessage,
                  ),
              },
            ),
          ),
        );
      },
    );
  }
}

class _ActionTodoModalBottomSheetInitialView extends StatelessWidget {
  const _ActionTodoModalBottomSheetInitialView({
    required this.todo,
    required this.errorMessage,
  });

  final TodoModel todo;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Actions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: CustomButton.primary(
                text: todo.isCompleted
                    ? const Text('Incomplete')
                    : const Text('Complete'),
                onPressed: () {
                  context
                      .read<ActionTodoBloc>()
                      .add(ActionTodoToggleCompleteButtonPressed(todo.id));
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CustomButton.secondary(
                text: const Text('Delete'),
                onPressed: () {
                  context
                      .read<ActionTodoBloc>()
                      .add(ActionTodoDeleteButtonPressed(todo.id));
                },
              ),
            ),
          ],
        ),
        if (errorMessage.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: ErrorTile.red(
              errorMessage: errorMessage,
            ),
          ),
      ],
    );
  }
}

class _ActionTodoModalBottomSheetLoadingView extends StatelessWidget {
  const _ActionTodoModalBottomSheetLoadingView();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Actions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Saving changes...',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            SizedBox(width: 8),
            SizedBox.square(
              dimension: 16,
              child: CircularProgressIndicator.adaptive(),
            ),
          ],
        ),
      ],
    );
  }
}

class _ActionTodoModalBottomSheetSuccessView extends StatelessWidget {
  const _ActionTodoModalBottomSheetSuccessView(
      {required this.actionCompletionMessage});

  final String actionCompletionMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Actions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              actionCompletionMessage,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
