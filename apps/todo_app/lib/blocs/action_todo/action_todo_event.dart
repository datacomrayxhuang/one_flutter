part of 'action_todo_bloc.dart';

sealed class ActionTodoEvent {
  const ActionTodoEvent();
}

class ActionTodoToggleCompleteButtonPressed extends ActionTodoEvent {
  final String todoId;

  const ActionTodoToggleCompleteButtonPressed(this.todoId);
}

class ActionTodoDeleteButtonPressed extends ActionTodoEvent {
  final String todoId;

  const ActionTodoDeleteButtonPressed(this.todoId);
}
