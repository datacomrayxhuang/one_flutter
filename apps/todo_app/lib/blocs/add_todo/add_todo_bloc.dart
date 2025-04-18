import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/repository/todo_repository.dart';
import 'package:todo_app/utils/result.dart';

part 'add_todo_event.dart';
part 'add_todo_state.dart';

class AddTodoBloc extends Bloc<AddTodoEvent, AddTodoState> {
  AddTodoBloc({
    required TodoRepository todoRepository,
  })  : _todoRepository = todoRepository,
        super(AddTodoState.initial) {
    on<AddTodoTitleChanged>(_onAddTodoTitleChanged);
    on<AddTodoDescriptionChanged>(_onAddTodoDescriptionChanged);
    on<AddTodoSaveButtonPressed>(_onAddTodoSaveButtonPressed);
    on<AddTodoClearButtonPressed>(_onAddTodoClearButtonPressed);
  }

  final TodoRepository _todoRepository;

  // Handle title changed
  void _onAddTodoTitleChanged(
    AddTodoTitleChanged event,
    Emitter<AddTodoState> emit,
  ) {
    emit(
      state.copyWith(
        title: event.title,
        errorMessage: '',
      ),
    );
  }

  // Handle description changed
  void _onAddTodoDescriptionChanged(
    AddTodoDescriptionChanged event,
    Emitter<AddTodoState> emit,
  ) {
    emit(
      state.copyWith(
        description: event.description,
        errorMessage: '',
      ),
    );
  }

  // Handle save button pressed
  Future<void> _onAddTodoSaveButtonPressed(
    AddTodoSaveButtonPressed event,
    Emitter<AddTodoState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        errorMessage: '',
      ),
    );

    final Result<bool> result = await _todoRepository.addTodo(
      state.title,
      state.description,
    );

    switch (result) {
      case Ok<bool>():
        emit(
          state.copyWith(
            isLoading: false,
            status: AddTodoStatus.success,
          ),
        );
        break;
      case Error<bool>():
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: 'Unable to add To-Do, please try again.',
          ),
        );
        break;
    }
  }

  // Handle clear button pressed
  void _onAddTodoClearButtonPressed(
    AddTodoClearButtonPressed event,
    Emitter<AddTodoState> emit,
  ) {
    emit(
      state.copyWith(
        title: '',
        description: '',
        errorMessage: '',
      ),
    );
  }
}
