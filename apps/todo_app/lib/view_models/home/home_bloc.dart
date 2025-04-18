import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/repository/todo_repository.dart';
import 'package:todo_app/utils/result.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required TodoRepository todoRepository,
  })  : _todoRepository = todoRepository,
        super(HomeState.initial) {
    on<HomeFetchTodosRequested>(_onHomeFetchTodosRequested);
  }

  final TodoRepository _todoRepository;

  Future<void> _onHomeFetchTodosRequested(
    HomeFetchTodosRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      final Result<List<TodoModel>> result = await _todoRepository.getTodos();
      switch (result) {
        case Ok<List<TodoModel>>():
          emit(
            state.copyWith(
              todos: result.value,
              isLoading: false,
            ),
          );
          break;
        case Error<List<TodoModel>>():
          emit(
            state.copyWith(
              errorMessage: result.error.toString(),
              isLoading: false,
            ),
          );
          break;
      }
    } catch (e) {
      emit(state.copyWith(
        errorMessage: e.toString(),
        isLoading: false,
      ));
    }
  }
}
