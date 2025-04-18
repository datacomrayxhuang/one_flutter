import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/repository/secure_storage.dart';
import 'package:todo_app/repository/todo_repository.dart';
import 'package:todo_app/utils/result.dart';

// Mock class for SecureStorage
class MockSecureStorage extends Mock implements SecureStorage {}

void main() {
  late TodoRepository todoRepository;
  late MockSecureStorage mockSecureStorage;

  setUp(() {
    mockSecureStorage = MockSecureStorage();
    todoRepository = TodoRepository(secureStorage: mockSecureStorage);
  });

  setUpAll(() {
    // Register fallback values for mocktail
    registerFallbackValue('');
  });

  group('TodoRepository', () {
    test('getTodos returns empty list when no todos are stored', () async {
      when(() => mockSecureStorage.read(key: 'todos'))
          .thenAnswer((_) async => null);

      final result = await todoRepository.getTodos();

      expect(result, isA<Ok<List<TodoModel>>>());
      expect((result as Ok<List<TodoModel>>).value, isEmpty);
    });

    test('getTodos returns list of todos when todos are stored', () async {
      final todosJson = jsonEncode([
        {
          'id': '1',
          'title': 'Test Todo',
          'description': 'Test Description',
          'isCompleted': false
        }
      ]);
      when(() => mockSecureStorage.read(key: 'todos'))
          .thenAnswer((_) async => todosJson);

      final result = await todoRepository.getTodos();

      expect(result, isA<Ok<List<TodoModel>>>());
      final todos = (result as Ok<List<TodoModel>>).value;
      expect(todos, hasLength(1));
      expect(todos.first.id, '1');
      expect(todos.first.title, 'Test Todo');
    });

    test('addTodo adds a new todo successfully', () async {
      when(() => mockSecureStorage.read(key: 'todos'))
          .thenAnswer((_) async => null);
      when(() =>
              mockSecureStorage.write(key: 'todos', value: any(named: 'value')))
          .thenAnswer((_) async => true);

      final result =
          await todoRepository.addTodo('New Todo', 'New Description');

      expect(result, isA<Ok<bool>>());
      expect((result as Ok<bool>).value, isTrue);
    });

    test('addTodo fails when title or description is empty', () async {
      final result = await todoRepository.addTodo('', '');

      expect(result, isA<Error<bool>>());
      expect((result as Error<bool>).error.toString(),
          contains('Title and description cannot be empty'));
    });

    test('toggleTodoCompletion toggles the completion status of a todo',
        () async {
      final todosJson = jsonEncode([
        {
          'id': '1',
          'title': 'Test Todo',
          'description': 'Test Description',
          'isCompleted': false
        }
      ]);
      when(() => mockSecureStorage.read(key: 'todos'))
          .thenAnswer((_) async => todosJson);
      when(() =>
              mockSecureStorage.write(key: 'todos', value: any(named: 'value')))
          .thenAnswer((_) async => true);

      final result = await todoRepository.toggleTodoCompletion('1');

      expect(result, isA<Ok<bool>>());
      expect((result as Ok<bool>).value, isTrue);
    });

    test('deleteTodo removes a todo successfully', () async {
      final todosJson = jsonEncode([
        {
          'id': '1',
          'title': 'Test Todo',
          'description': 'Test Description',
          'isCompleted': false
        }
      ]);
      when(() => mockSecureStorage.read(key: 'todos'))
          .thenAnswer((_) async => todosJson);
      when(() =>
              mockSecureStorage.write(key: 'todos', value: any(named: 'value')))
          .thenAnswer((_) async => true);

      final result = await todoRepository.deleteTodo('1');

      expect(result, isA<Ok<bool>>());
      expect((result as Ok<bool>).value, isTrue);
    });

    test('deleteAllTodos clears all todos successfully', () async {
      when(() => mockSecureStorage.delete(key: 'todos'))
          .thenAnswer((_) async => true);

      final result = await todoRepository.deleteAllTodos();

      expect(result, isA<Ok<bool>>());
      expect((result as Ok<bool>).value, isTrue);
    });
  });
}
