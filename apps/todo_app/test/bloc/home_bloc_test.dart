import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/repository/todo_repository.dart';
import 'package:todo_app/utils/result.dart';
import 'package:todo_app/blocs/home/home_bloc.dart';

class MockTodoRepository extends Mock implements TodoRepository {}

void main() {
  late HomeBloc homeBloc;
  late MockTodoRepository mockTodoRepository;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    homeBloc = HomeBloc(todoRepository: mockTodoRepository);
  });

  tearDown(() {
    homeBloc.close();
  });

  group('HomeBloc', () {
    const List<TodoModel> mockTodos = [
      TodoModel(
        id: '1',
        title: 'Test Todo',
        description: 'Test Description',
        isCompleted: false,
      ),
    ];

    test('initial state is HomeState.initial', () {
      expect(homeBloc.state, HomeState.initial);
    });

    blocTest<HomeBloc, HomeState>(
      'emits [loading, success] when getTodos succeeds',
      build: () {
        when(() => mockTodoRepository.getTodos())
            .thenAnswer((_) async => Result.ok(mockTodos));
        return homeBloc;
      },
      act: (bloc) => bloc.add(const HomeFetchTodosRequested()),
      expect: () => [
        HomeState.initial.copyWith(isLoading: true),
        HomeState.initial.copyWith(
          todos: mockTodos,
          isLoading: false,
        ),
      ],
      verify: (_) {
        verify(() => mockTodoRepository.getTodos()).called(1);
      },
    );

    blocTest<HomeBloc, HomeState>(
      'emits [loading, error] when getTodos fails',
      build: () {
        when(() => mockTodoRepository.getTodos()).thenAnswer(
            (_) async => Result.error(Exception('Error fetching todos')));
        return homeBloc;
      },
      act: (bloc) => bloc.add(const HomeFetchTodosRequested()),
      expect: () => [
        HomeState.initial.copyWith(isLoading: true),
        HomeState.initial.copyWith(
          errorMessage: 'Exception: Error fetching todos',
          isLoading: false,
        ),
      ],
      verify: (_) {
        verify(() => mockTodoRepository.getTodos()).called(1);
      },
    );

    blocTest<HomeBloc, HomeState>(
      'emits [loading, error] when an exception is thrown',
      build: () {
        when(() => mockTodoRepository.getTodos())
            .thenThrow(Exception('Unexpected error'));
        return homeBloc;
      },
      act: (bloc) => bloc.add(const HomeFetchTodosRequested()),
      expect: () => [
        HomeState.initial.copyWith(isLoading: true),
        HomeState.initial.copyWith(
          errorMessage: 'Exception: Unexpected error',
          isLoading: false,
        ),
      ],
      verify: (_) {
        verify(() => mockTodoRepository.getTodos()).called(1);
      },
    );
  });
}
