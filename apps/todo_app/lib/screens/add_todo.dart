import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/blocs/add_todo/add_todo_bloc.dart';
import 'package:ui_elements/widgets/custom_app_bar.dart';
import 'package:ui_elements/widgets/custom_button.dart';
import 'package:ui_elements/widgets/custom_text_field.dart';
import 'package:ui_elements/widgets/error_tile.dart';

/// The `AddTodoPage` widget allows users to add a new to-do item to the list.
///
/// This page provides a form with fields for entering the title and description of the to-do.
/// It also includes a save button to submit the to-do and a clear button to reset the form.
/// The page uses the `AddTodoBloc` for state management and integrates with the `GoRouter`
/// for navigation.
///
/// ### Features:
/// - **Title Field**: A text field for entering the title of the to-do.
/// - **Description Field**: A text field for entering the description of the to-do.
/// - **Save Button**: A button to save the to-do. It is disabled if the fields are empty.
/// - **Clear Button**: A button to clear the form fields.
/// - **Loading Indicator**: Displays a loading indicator when the to-do is being saved.
/// - **Success View**: Displays a success message after the to-do is added successfully.
///
/// ### State Management:
/// - The widget listens to the `AddTodoBloc` to update its UI based on the current state:
///   - `AddTodoStatus.initial`: Displays the form for adding a to-do.
///   - `AddTodoStatus.success`: Displays a success message after the to-do is added.
///
/// ### Dependencies:
/// - `AddTodoBloc`: Manages the state of the to-do addition process.
/// - `CustomAppBar`: Displays the app bar with a title and optional actions.
/// - `CustomTextField`: Used for the title and description input fields.
/// - `CustomButton`: Used for the save and clear buttons.
/// - `ErrorTile`: Displays error messages when the to-do addition fails.
///
/// ### Widgets Used:
/// - `CustomAppBar`: Displays the app bar with a title, back button, and clear button.
/// - `CustomTextField`: Provides input fields for the title and description.
/// - `CustomButton`: Provides buttons for saving and clearing the form.
/// - `ErrorTile`: Displays error messages.
/// - `_AddTodoSuccessView`: Displays a success message after the to-do is added.
///
/// ### Example:
/// ```dart
/// MaterialApp(
///   home: BlocProvider(
///     create: (context) => AddTodoBloc(todoRepository: TodoRepository()),
///     child: const AddTodoPage(),
///   ),
/// );
/// ```
///
/// ### Parameters:
/// - `key`: An optional key for the widget.
///
/// ### Actions:
/// - **Save To-Do**: The save button submits the to-do to the `AddTodoBloc`.
/// - **Clear Form**: The clear button resets the form fields and updates the state.
/// - **Dismiss Keyboard**: Tapping outside the form dismisses the keyboard.
///
/// ### Notes:
/// - The save button is disabled if the title or description fields are empty.
/// - The page automatically transitions to the success view after the to-do is added successfully.
/// - The clear button is only visible when the form fields are not empty.
///
/// ### Success View:
/// - Displays a check icon, a success message, and a button to return to the previous screen.
class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  /// The route name for the AddTodoPage.
  /// This is used to navigate to this page using the GoRouter
  /// and to register the route in the GoRouter.
  static const String routeName = '/add-todo';

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  /// The text controllers for the title and description text fields.
  /// These controllers are used to get the text from the text fields
  /// and to clear the text fields when the clear button is pressed.
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  /// Handle clear button pressed.
  /// Clear the text fields and unfocus the keyboard and
  /// emit the AddTodoClearButtonPressed event to the AddTodoBloc to update the state.
  void _onClearButtonPressed() {
    _titleController.clear();
    _descriptionController.clear();
    context.read<AddTodoBloc>().add(const AddTodoClearButtonPressed());
    FocusManager.instance.primaryFocus?.unfocus();
  }

  /// Handle save button pressed.
  /// Emit the AddTodoSaveButtonPressed event to the AddTodoBloc to save the todo.
  void _onSaveButtonPressed() {
    context.read<AddTodoBloc>().add(const AddTodoSaveButtonPressed());
  }

  /// Builds the app bar with a title, back button, and clear button.
  PreferredSizeWidget _buildAppBar(
      BuildContext context, AddTodoState addTodoState) {
    return CustomAppBar(
      title: 'Add To-Do',
      hasBackButton: true,
      actions: [
        AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: addTodoState.hasClearButton ? 1 : 0,
          child: IconButton(
            icon: Icon(
              Icons.clear,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed:
                addTodoState.hasClearButton ? _onClearButtonPressed : null,
          ),
        ),
      ],
    );
  }

  /// Builds the body of the page, showing the form or success view.
  Widget _buildBody(BuildContext context, AddTodoState addTodoState) {
    return SizedBox.expand(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        behavior: HitTestBehavior.opaque,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: switch (addTodoState.status) {
              AddTodoStatus.initial => _buildForm(context, addTodoState),
              AddTodoStatus.success => const _AddTodoSuccessView(),
            },
          ),
        ),
      ),
    );
  }

  /// Builds the form with title, description, save button, and error message.
  Widget _buildForm(BuildContext context, AddTodoState addTodoState) {
    return Column(
      children: [
        _getTitleTextField(isReadOnly: addTodoState.isLoading),
        const SizedBox(height: 16),
        _getDescriptionTextField(isReadOnly: addTodoState.isLoading),
        const SizedBox(height: 16),
        _getSaveButton(isLoading: addTodoState.isLoading),
        if (addTodoState.errorMessage.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: ErrorTile.red(
              errorMessage: addTodoState.errorMessage,
            ),
          ),
      ],
    );
  }

  /// Get the title text field.
  /// If the isReadOnly parameter is true, the text field will be read-only
  /// and the input decoration will be disabled.
  /// If the isReadOnly parameter is false, the text field will be editable
  /// and the input decoration will be enabled.
  Widget _getTitleTextField({required bool isReadOnly}) {
    return CustomTextField(
      controller: _titleController,
      readOnly: isReadOnly,
      maxLength: 50,
      inputDecoration: isReadOnly
          ? CustomTextField.defaultDisabledInputDecoration.copyWith(
              labelText: 'Title',
            )
          : CustomTextField.defaultInputDecoration.copyWith(
              labelText: 'Title',
              alignLabelWithHint: true,
            ),
      onChanged: (text) =>
          context.read<AddTodoBloc>().add(AddTodoTitleChanged(text)),
    );
  }

  /// Get the description text field.
  /// If the isReadOnly parameter is true, the text field will be read-only
  /// and the input decoration will be disabled.
  /// If the isReadOnly parameter is false, the text field will be editable
  /// and the input decoration will be enabled.
  Widget _getDescriptionTextField({required bool isReadOnly}) {
    return CustomTextField(
      controller: _descriptionController,
      readOnly: isReadOnly,
      maxLines: 5,
      maxLength: 1000,
      inputDecoration: isReadOnly
          ? CustomTextField.defaultDisabledInputDecoration.copyWith(
              labelText: 'Description',
            )
          : CustomTextField.defaultInputDecoration.copyWith(
              labelText: 'Description',
              alignLabelWithHint: true,
            ),
      onChanged: (text) =>
          context.read<AddTodoBloc>().add(AddTodoDescriptionChanged(text)),
    );
  }

  /// Get the save button.
  /// If the isLoading parameter is true, the button will be disabled
  /// and show a loading indicator.
  /// If the isLoading parameter is false, the button will be enabled.
  Widget _getSaveButton({required bool isLoading}) {
    return isLoading
        ? const CustomButton.primary(
            text: Text('Saving...'),
            onPressed: null,
            trailingIcon: SizedBox.square(
              dimension: 16,
              child: CircularProgressIndicator.adaptive(),
            ),
          )
        : CustomButton.primary(
            text: const Text('Save'),
            disabled: _titleController.text.isEmpty ||
                _descriptionController.text.isEmpty,
            onPressed: _onSaveButtonPressed,
          );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTodoBloc, AddTodoState>(
      builder: (context, addTodoState) {
        return Scaffold(
          appBar: _buildAppBar(context, addTodoState),
          body: _buildBody(context, addTodoState),
        );
      },
    );
  }
}

/// A widget that shows a success message after adding a todo.
/// This widget is shown when the todo is added successfully
/// It shows a check icon, a success message, and a button to go back
class _AddTodoSuccessView extends StatelessWidget {
  const _AddTodoSuccessView();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 100,
        ),
        const SizedBox(height: 16),
        const Text(
          'Todo added successfully',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'You can now go back to the home screen',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 16),
        CustomButton.primary(
          text: const Text('Done'),
          onPressed: () => context.pop(),
        ),
      ],
    );
  }
}
