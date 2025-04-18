import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/view_models/add_todo/add_todo_bloc.dart';
import 'package:ui_elements/widgets/custom_app_bar.dart';
import 'package:ui_elements/widgets/custom_button.dart';
import 'package:ui_elements/widgets/custom_text_field.dart';
import 'package:ui_elements/widgets/error_tile.dart';

/// A page that allows the user to add a new todo.
/// This page is used to add a new todo to the list of todos
/// It shows a form with a title and description text fields
/// and a save button to save the todo.
/// It also shows a clear button to clear the text fields
/// and a loading indicator when the todo is being added.
/// The page is implemented using the Bloc pattern
/// and the state is managed by the [AddTodoBloc].
/// The page is registered in the [GoRouter]
/// and can be navigated to using the [routeName].
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
          // Render the app bar with a title and a back button
          // and a clear button if there is text in the text fields.
          appBar: CustomAppBar(
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
                  onPressed: addTodoState.hasClearButton
                      ? _onClearButtonPressed
                      : null,
                ),
              ),
            ],
          ),
          body: SizedBox.expand(
            child: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              behavior: HitTestBehavior.opaque,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: switch (addTodoState.status) {
                    /// Show inital view if the todo is being added
                    AddTodoStatus.initial => Column(
                        children: [
                          /// Show the title text field
                          _getTitleTextField(
                            isReadOnly: addTodoState.isLoading,
                          ),
                          const SizedBox(height: 16),

                          /// Show the description text field
                          _getDescriptionTextField(
                            isReadOnly: addTodoState.isLoading,
                          ),
                          const SizedBox(height: 16),

                          /// Show the save button
                          _getSaveButton(
                            isLoading: addTodoState.isLoading,
                          ),

                          /// Show error message if there is an error
                          if (addTodoState.errorMessage.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: ErrorTile.red(
                                errorMessage: addTodoState.errorMessage,
                              ),
                            ),
                        ],
                      ),

                    /// Show success view if the todo is added successfully
                    AddTodoStatus.success => const _AddTodoSuccessView(),
                  },
                ),
              ),
            ),
          ),
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
