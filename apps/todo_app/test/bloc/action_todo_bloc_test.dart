import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/repository/todo_repository.dart';
import 'package:todo_app/utils/result.dart';
import 'package:todo_app/blocs/action_todo/action_todo_bloc.dart';

class MockTodoRepository extends Mock implements TodoRepository {}

void main() {
  late ActionTodoBloc actionTodoBloc;
  late MockTodoRepository mockTodoRepository;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    actionTodoBloc = ActionTodoBloc(todoRepository: mockTodoRepository);
  });

  tearDown(() {
    actionTodoBloc.close();
  });

  group('ActionTodoBloc', () {
    const String todoId = '1';

    test('initial state is ActionTodoState.initial', () {
      expect(actionTodoBloc.state, ActionTodoState.initial);
    });

    blocTest<ActionTodoBloc, ActionTodoState>(
      'emits [loading, success] when toggleTodoCompletion succeeds',
      build: () {
        when(() => mockTodoRepository.toggleTodoCompletion(todoId))
            .thenAnswer((_) async => Result.ok(true));
        return actionTodoBloc;
      },
      act: (bloc) =>
          bloc.add(const ActionTodoToggleCompleteButtonPressed(todoId)),
      expect: () => [
        ActionTodoState.initial.copyWith(
          status: ActionTodoStateStatus.loading,
          errorMessage: '',
          hasActed: true,
        ),
        ActionTodoState.initial.copyWith(
          status: ActionTodoStateStatus.success,
          errorMessage: '',
          actionCompletionMessage: 'Todo completion updated successfully.',
          hasActed: true,
        ),
      ],
      verify: (_) {
        verify(() => mockTodoRepository.toggleTodoCompletion(todoId)).called(1);
      },
    );

    blocTest<ActionTodoBloc, ActionTodoState>(
      'emits [loading, initial] with error message when toggleTodoCompletion fails',
      build: () {
        when(() => mockTodoRepository.toggleTodoCompletion(todoId))
            .thenAnswer((_) async => Result.error(Exception('Error')));
        return actionTodoBloc;
      },
      act: (bloc) =>
          bloc.add(const ActionTodoToggleCompleteButtonPressed(todoId)),
      expect: () => [
        ActionTodoState.initial.copyWith(
          status: ActionTodoStateStatus.loading,
          errorMessage: '',
          hasActed: true,
        ),
        ActionTodoState.initial.copyWith(
          status: ActionTodoStateStatus.initial,
          errorMessage: 'Unable to update todo completion, please try again.',
          hasActed: true,
        ),
      ],
      verify: (_) {
        verify(() => mockTodoRepository.toggleTodoCompletion(todoId)).called(1);
      },
    );

    blocTest<ActionTodoBloc, ActionTodoState>(
      'emits [loading, success] when deleteTodo succeeds',
      build: () {
        when(() => mockTodoRepository.deleteTodo(todoId))
            .thenAnswer((_) async => Result.ok(true));
        return actionTodoBloc;
      },
      act: (bloc) => bloc.add(const ActionTodoDeleteButtonPressed(todoId)),
      expect: () => [
        ActionTodoState.initial.copyWith(
          status: ActionTodoStateStatus.loading,
          errorMessage: '',
          hasActed: true,
        ),
        ActionTodoState.initial.copyWith(
          status: ActionTodoStateStatus.success,
          errorMessage: '',
          actionCompletionMessage: 'Todo deleted successfully.',
          hasActed: true,
        ),
      ],
      verify: (_) {
        verify(() => mockTodoRepository.deleteTodo(todoId)).called(1);
      },
    );

    blocTest<ActionTodoBloc, ActionTodoState>(
      'emits [loading, initial] with error message when deleteTodo fails',
      build: () {
        when(() => mockTodoRepository.deleteTodo(todoId))
            .thenAnswer((_) async => Result.error(Exception('Error')));
        return actionTodoBloc;
      },
      act: (bloc) => bloc.add(const ActionTodoDeleteButtonPressed(todoId)),
      expect: () => [
        ActionTodoState.initial.copyWith(
          status: ActionTodoStateStatus.loading,
          errorMessage: '',
          hasActed: true,
        ),
        ActionTodoState.initial.copyWith(
          status: ActionTodoStateStatus.initial,
          errorMessage: 'Unable to delete todo, please try again.',
          hasActed: true,
        ),
      ],
      verify: (_) {
        verify(() => mockTodoRepository.deleteTodo(todoId)).called(1);
      },
    );
  });
}
