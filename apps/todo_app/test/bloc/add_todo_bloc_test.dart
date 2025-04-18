import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/repository/todo_repository.dart';
import 'package:todo_app/utils/result.dart';
import 'package:todo_app/blocs/add_todo/add_todo_bloc.dart';

class MockTodoRepository extends Mock implements TodoRepository {}

void main() {
  late MockTodoRepository mockTodoRepository;
  late AddTodoBloc addTodoBloc;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    addTodoBloc = AddTodoBloc(todoRepository: mockTodoRepository);
  });

  tearDown(() {
    addTodoBloc.close();
  });

  group('AddTodoBloc', () {
    test('initial state is AddTodoState.initial', () {
      expect(addTodoBloc.state, AddTodoState.initial);
    });

    blocTest<AddTodoBloc, AddTodoState>(
      'emits state with updated title when AddTodoTitleChanged is added',
      build: () => addTodoBloc,
      act: (bloc) => bloc.add(const AddTodoTitleChanged('New Title')),
      expect: () => [
        AddTodoState.initial.copyWith(
          title: 'New Title',
          errorMessage: '',
        ),
      ],
    );

    blocTest<AddTodoBloc, AddTodoState>(
      'emits state with updated description when AddTodoDescriptionChanged is added',
      build: () => addTodoBloc,
      act: (bloc) =>
          bloc.add(const AddTodoDescriptionChanged('New Description')),
      expect: () => [
        AddTodoState.initial.copyWith(
          description: 'New Description',
          errorMessage: '',
        ),
      ],
    );

    blocTest<AddTodoBloc, AddTodoState>(
      'emits loading and success states when AddTodoSaveButtonPressed is added and repository returns success',
      build: () {
        when(() => mockTodoRepository.addTodo(any(), any()))
            .thenAnswer((_) async => const Ok(true));
        return addTodoBloc;
      },
      act: (bloc) => bloc.add(const AddTodoSaveButtonPressed()),
      expect: () => [
        AddTodoState.initial.copyWith(
          isLoading: true,
          errorMessage: '',
        ),
        AddTodoState.initial.copyWith(
          isLoading: false,
          status: AddTodoStatus.success,
          errorMessage: '',
        ),
      ],
    );

    blocTest<AddTodoBloc, AddTodoState>(
      'emits loading and error states when AddTodoSaveButtonPressed is added and repository returns error',
      build: () {
        when(() => mockTodoRepository.addTodo(any(), any()))
            .thenAnswer((_) async => Error(Exception('Error')));
        return addTodoBloc;
      },
      act: (bloc) => bloc.add(const AddTodoSaveButtonPressed()),
      expect: () => [
        AddTodoState.initial.copyWith(
          isLoading: true,
          errorMessage: '',
        ),
        AddTodoState.initial.copyWith(
          isLoading: false,
          errorMessage: 'Unable to add To-Do, please try again.',
        ),
      ],
    );

    blocTest<AddTodoBloc, AddTodoState>(
      'emits initial state when AddTodoClearButtonPressed is added',
      build: () => addTodoBloc,
      act: (bloc) => bloc.add(const AddTodoClearButtonPressed()),
      expect: () => [
        AddTodoState.initial.copyWith(
          title: '',
          description: '',
          errorMessage: '',
        ),
      ],
    );
  });
}
