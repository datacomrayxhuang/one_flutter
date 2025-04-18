import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/repository/todo_repository.dart';
import 'package:todo_app/screens/add_todo.dart';
import 'package:todo_app/blocs/action_todo/action_todo_bloc.dart';
import 'package:todo_app/blocs/home/home_bloc.dart';
import 'package:todo_app/widgets/action_todo_modal_bottom_sheet.dart';
import 'package:ui_elements/styles/color_constants.dart';
import 'package:ui_elements/widgets/custom_app_bar.dart';
import 'package:ui_elements/widgets/expandable_text_tile.dart';
import 'package:ui_elements/widgets/loading_view.dart';

/// The `HomePage` widget serves as the main screen of the to-do application.
///
/// This widget displays a list of to-do items and allows users to perform various actions,
/// such as adding, updating, or deleting to-dos. It uses the `HomeBloc` for state management
/// and integrates with other widgets like `ExpandableTextTile` and `ActionTodoModalBottomSheet`
/// to provide a seamless user experience.
///
/// ### Features:
/// - **To-Do List**: Displays a list of to-do items fetched from the `HomeBloc`.
/// - **Add To-Do**: Provides a floating action button to navigate to the `AddTodoPage`.
/// - **Refresh**: Allows users to refresh the to-do list.
/// - **Long Press Actions**: Opens a modal bottom sheet for additional actions on a to-do item.
/// - **Empty State**: Displays a friendly message when there are no to-dos available.
///
/// ### State Management:
/// - The widget listens to the `HomeBloc` to update its UI based on the current state:
///   - `isLoading`: Displays a loading indicator while the to-dos are being fetched.
///   - `todos`: Displays the list of to-dos or an empty state if the list is empty.
///
/// ### Dependencies:
/// - `HomeBloc`: Manages the state of the to-do list.
/// - `ActionTodoBloc`: Handles actions like marking a to-do as complete or deleting it.
/// - `TodoRepository`: Provides the data layer for fetching and managing to-dos.
///
/// ### Widgets Used:
/// - `CustomAppBar`: Displays the app bar with a title and optional actions.
/// - `ExpandableTextTile`: Displays each to-do item with expandable descriptions.
/// - `ActionTodoModalBottomSheet`: Provides additional actions for a to-do item.
/// - `LoadingView`: Displays a loading indicator.
/// - `_HomeEmptyView`: Displays a message when there are no to-dos.
///
/// ### Example:
/// ```dart
/// MaterialApp(
///   home: BlocProvider(
///     create: (context) => HomeBloc(todoRepository: TodoRepository()),
///     child: const HomePage(),
///   ),
/// );
/// ```
///
/// ### Parameters:
/// - `key`: An optional key for the widget.
///
/// ### Actions:
/// - **Add To-Do**: The floating action button navigates to the `AddTodoPage`.
/// - **Refresh**: The refresh button fetches the latest to-dos from the repository.
/// - **Long Press**: Opens a modal bottom sheet for actions like marking a to-do as complete or deleting it.
///
/// ### Notes:
/// - The `FloatingActionButton` automatically refreshes the to-do list after a new to-do is added.
/// - The `ActionTodoModalBottomSheet` is dismissed automatically after an action is performed.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String routeName = '/home';

  /// This method is called when a todo tile is long-pressed.
  /// It opens a modal bottom sheet that allows the user to perform actions
  /// on the selected todo item.
  /// The method uses the `ActionTodoBloc` to manage the state of the actions.
  /// After the modal bottom sheet is closed, it checks if the user has acted
  /// and fetches the todos again if necessary.
  void _onTodoTileLongPressed(BuildContext context, {required TodoModel todo}) {
    final ActionTodoBloc actionTodoBloc = ActionTodoBloc(
      todoRepository: context.read<TodoRepository>(),
    ); // Access the ActionTodoBloc

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return BlocProvider<ActionTodoBloc>.value(
          value: actionTodoBloc, // Provide the ActionTodoBloc;
          child: ActionTodoModalBottomSheet(todo: todo),
        );
      },
    ).then((_) {
      if (!context.mounted) return;

      if (actionTodoBloc.state.hasActed) {
        // If the user has acted, fetch the todos again
        context.read<HomeBloc>().add(const HomeFetchTodosRequested());
      }

      // If the user has not acted, we can choose to do nothing
    });
  }

  /// Builds the app bar with a title and optional refresh button.
  PreferredSizeWidget _buildAppBar(BuildContext context, HomeState homeState) {
    return CustomAppBar(
      title: 'Home',
      hasBackButton: false,
      actions: [
        if (!homeState.isLoading && homeState.todos.isEmpty)
          IconButton(
            icon: const Icon(
              Icons.refresh,
              color: kWhiteColor,
            ),
            onPressed: () =>
                context.read<HomeBloc>().add(const HomeFetchTodosRequested()),
          ),
      ],
    );
  }

  /// Builds the body of the page, showing a loading view, the todo list, or an empty state.
  Widget _buildBody(BuildContext context, HomeState homeState) {
    if (homeState.isLoading) {
      return const LoadingView();
    }

    return RefreshIndicator.adaptive(
      onRefresh: () async =>
          context.read<HomeBloc>().add(const HomeFetchTodosRequested()),
      child: homeState.todos.isNotEmpty
          ? _buildTodoList(context, homeState.todos)
          : const _HomeEmptyView(),
    );
  }

  /// Builds the list of todos.
  Widget _buildTodoList(BuildContext context, List<TodoModel> todos) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (BuildContext context, int index) {
        final bool isLastItem = index == todos.length - 1;
        final TodoModel todo = todos[index];

        final Widget tile = ExpandableTextTile(
          title: todo.title,
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            decoration: todo.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
          description: todo.description,
          descriptionTextStyle: TextStyle(
            fontSize: 14,
            decoration: todo.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
          onLongPress: () => _onTodoTileLongPressed(context, todo: todo),
        );

        // Add padding to the last item to prevent it from being cut off by the floating action button
        if (isLastItem) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 72),
            child: tile,
          );
        }

        return tile;
      },
    );
  }

  /// Builds the floating action button for adding a new todo.
  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => context.push(AddTodoPage.routeName).then(
        (popResult) {
          if (!context.mounted) return;
          context.read<HomeBloc>().add(const HomeFetchTodosRequested());
        },
      ),
      tooltip: 'Add To-Do',
      label: const Text('Add To-Do'),
      icon: const Icon(Icons.add),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (BuildContext context, HomeState homeState) {
        return Scaffold(
          appBar: _buildAppBar(context, homeState),
          body: _buildBody(context, homeState),
          floatingActionButton: _buildFloatingActionButton(context),
        );
      },
    );
  }
}

/// A widget that displays a message when there are no todos available.
/// It shows an icon and a message prompting the user to add their first todo.
/// This widget is used in the [HomePage] when the todo list is empty.
/// It is a private widget and should not be used outside of this file.
class _HomeEmptyView extends StatelessWidget {
  const _HomeEmptyView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox,
            size: 80,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            'No todos available',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Tap the button below to add your first todo!',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
