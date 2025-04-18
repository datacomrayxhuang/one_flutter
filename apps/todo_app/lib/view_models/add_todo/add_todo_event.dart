part of 'add_todo_bloc.dart';

sealed class AddTodoEvent {
  const AddTodoEvent();
}

class AddTodoTitleChanged extends AddTodoEvent {
  const AddTodoTitleChanged(this.title);

  final String title;
}

class AddTodoDescriptionChanged extends AddTodoEvent {
  const AddTodoDescriptionChanged(this.description);

  final String description;
}

class AddTodoClearButtonPressed extends AddTodoEvent {
  const AddTodoClearButtonPressed();
}

class AddTodoSaveButtonPressed extends AddTodoEvent {
  const AddTodoSaveButtonPressed();
}
