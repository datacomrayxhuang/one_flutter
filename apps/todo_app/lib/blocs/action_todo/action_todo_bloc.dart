import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/repository/todo_repository.dart';
import 'package:todo_app/utils/result.dart';

part 'action_todo_state.dart';
part 'action_todo_event.dart';

class ActionTodoBloc extends Bloc<ActionTodoEvent, ActionTodoState> {
  ActionTodoBloc({
    required TodoRepository todoRepository,
  })  : _todoRepository = todoRepository,
        super(ActionTodoState.initial) {
    on<ActionTodoToggleCompleteButtonPressed>(
        _onActionTodoToggleCompleteButtonPressed);
    on<ActionTodoDeleteButtonPressed>(_onActionTodoDeleteButtonPressed);
  }

  final TodoRepository _todoRepository;

  Future<void> _onActionTodoToggleCompleteButtonPressed(
    ActionTodoToggleCompleteButtonPressed event,
    Emitter<ActionTodoState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ActionTodoStateStatus.loading,
        errorMessage: '',
        hasActed: true,
      ),
    );

    final Result<bool> result =
        await _todoRepository.toggleTodoCompletion(event.todoId);

    switch (result) {
      case Ok<bool>():
        emit(
          state.copyWith(
            status: ActionTodoStateStatus.success,
            errorMessage: '',
            actionCompletionMessage: 'Todo completion updated successfully.',
          ),
        );
        break;
      case Error<bool>():
        emit(
          state.copyWith(
            status: ActionTodoStateStatus.initial,
            errorMessage: 'Unable to update todo completion, please try again.',
          ),
        );
        break;
    }
  }

  Future<void> _onActionTodoDeleteButtonPressed(
    ActionTodoDeleteButtonPressed event,
    Emitter<ActionTodoState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ActionTodoStateStatus.loading,
        errorMessage: '',
        hasActed: true,
      ),
    );

    final Result<bool> result = await _todoRepository.deleteTodo(event.todoId);

    switch (result) {
      case Ok<bool>():
        emit(
          state.copyWith(
            status: ActionTodoStateStatus.success,
            errorMessage: '',
            actionCompletionMessage: 'Todo deleted successfully.',
          ),
        );
        break;
      case Error<bool>():
        emit(
          state.copyWith(
            status: ActionTodoStateStatus.initial,
            errorMessage: 'Unable to delete todo, please try again.',
          ),
        );
        break;
    }
  }
}
