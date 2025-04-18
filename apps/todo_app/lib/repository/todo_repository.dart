import 'dart:convert';

import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/repository/secure_storage.dart';
import 'package:todo_app/utils/result.dart';

/// The `TodoRepository` class provides methods to manage to-do items, including
/// fetching, adding, updating, and deleting todos. It uses `SecureStorage` for
/// persistent storage and returns results wrapped in a `Result` object for error handling.
///
/// ### Features:
/// - **Fetch Todos**: Retrieves the list of todos from persistent storage.
/// - **Add Todo**: Adds a new todo to the list.
/// - **Toggle Completion**: Toggles the completion status of a todo.
/// - **Delete Todo**: Deletes a specific todo by its ID.
/// - **Delete All Todos**: Clears all todos from persistent storage.
///
/// ### Methods:
/// - `getTodos()`: Fetches the list of todos.
/// - `addTodo(String title, String description)`: Adds a new todo.
/// - `toggleTodoCompletion(String id)`: Toggles the completion status of a todo.
/// - `deleteTodo(String id)`: Deletes a specific todo.
/// - `deleteAllTodos()`: Deletes all todos.
///
/// ### Dependencies:
/// - `SecureStorage`: Used for storing and retrieving todos persistently.
/// - `TodoModel`: Represents the structure of a to-do item.
/// - `Result`: Wraps the result of operations, handling success and error states.
///
/// ### Example Usage:
/// ```dart
/// final todoRepository = TodoRepository();
///
/// // Fetch todos
/// final todosResult = await todoRepository.getTodos();
/// if (todosResult is Ok<List<TodoModel>>) {
///   final todos = todosResult.value;
///   print('Fetched todos: $todos');
/// } else if (todosResult is Error<List<TodoModel>>) {
///   print('Error fetching todos: ${todosResult.error}');
/// }
///
/// // Add a new todo
/// final addResult = await todoRepository.addTodo('New Todo', 'Description');
/// if (addResult is Ok<bool>) {
///   print('Todo added successfully');
/// } else if (addResult is Error<bool>) {
///   print('Error adding todo: ${addResult.error}');
/// }
/// ```
///
/// ### Notes:
/// - All methods simulate network calls with a delay of 1 second.
/// - Errors are wrapped in the `Result.error` object for consistent error handling.
/// - The repository is implemented as a singleton to ensure a single instance is used throughout the app.
///
/// ### Error Handling:
/// - If an operation fails, the method returns a `Result.error` with an exception message.
/// - Example: `Result.error(Exception('An error occurred: $e'))`
class TodoRepository {
  static final TodoRepository _instance = TodoRepository._internal();

  SecureStorage? _secureStorage;

  factory TodoRepository({SecureStorage? secureStorage}) {
    _instance._secureStorage = secureStorage ?? SecureStorage();
    return _instance;
  }

  TodoRepository._internal();

  Future<Result<List<TodoModel>>> getTodos() async {
    try {
      // Simulate a network call
      await Future.delayed(const Duration(seconds: 1));

      final String? todos = await _secureStorage!.read(key: 'todos');
      if (todos == null) {
        return Result.ok([]);
      }

      final List<TodoModel> todosModel = (jsonDecode(todos) as List<dynamic>)
          .map((todo) => TodoModel.fromJson(todo))
          .toList();

      return Result.ok(todosModel);
    } catch (e) {
      return Result.error(Exception('An error occurred: $e'));
    }
  }

  Future<Result<bool>> addTodo(String title, String description) async {
    try {
      // Simulate a network call
      await Future.delayed(const Duration(seconds: 1));

      if (title.isEmpty || description.isEmpty) {
        return Result.error(Exception('Title and description cannot be empty'));
      }

      if (title.toLowerCase() == 'fail') {
        return Result.error(Exception('Failed to add todo'));
      }

      // Fetch the existing todos
      final Result<List<TodoModel>> todos = await getTodos();

      switch (todos) {
        case Ok<List<TodoModel>>():
          final List<TodoModel> todosList = todos.value;
          final TodoModel newTodo = TodoModel(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            title: title,
            description: description,
            isCompleted: false,
          );
          todosList.add(newTodo);

          // Save the updated list of todos
          _secureStorage!.write(
            key: 'todos',
            value: jsonEncode(todosList.map((todo) => todo.toJson()).toList()),
          );

          return Result.ok(true);
        case Error<List<TodoModel>>():
          return Result.error(todos.error);
      }
    } catch (e) {
      return Result.error(Exception('An error occurred: $e'));
    }
  }

  Future<Result<bool>> toggleTodoCompletion(String id) async {
    try {
      // Simulate a network call
      await Future.delayed(const Duration(seconds: 1));

      // Fetch the existing todos
      final Result<List<TodoModel>> todos = await getTodos();

      switch (todos) {
        case Ok<List<TodoModel>>():
          final List<TodoModel> todosList = todos.value;
          final List<TodoModel> updatedTodos = todosList.map((todo) {
            if (todo.id == id) {
              return todo.copyWith(isCompleted: !todo.isCompleted);
            }
            return todo;
          }).toList();

          // Save the updated list of todos
          await _secureStorage!.write(
            key: 'todos',
            value:
                jsonEncode(updatedTodos.map((todo) => todo.toJson()).toList()),
          );

          return Result.ok(true);
        case Error<List<TodoModel>>():
          return Result.error(todos.error);
      }
    } catch (e) {
      return Result.error(Exception('An error occurred: $e'));
    }
  }

  Future<Result<bool>> deleteTodo(String id) async {
    try {
      // Simulate a network call
      await Future.delayed(const Duration(seconds: 1));

      // Fetch the existing todos
      final Result<List<TodoModel>> todos = await getTodos();

      switch (todos) {
        case Ok<List<TodoModel>>():
          final List<TodoModel> todosList = todos.value;
          final updatedTodos =
              todosList.where((todo) => todo.id != id).toList();

          // Save the updated list of todos
          await _secureStorage!.write(
            key: 'todos',
            value:
                jsonEncode(updatedTodos.map((todo) => todo.toJson()).toList()),
          );

          return Result.ok(true);
        case Error<List<TodoModel>>():
          return Result.error(todos.error);
      }
    } catch (e) {
      return Result.error(Exception('An error occurred: $e'));
    }
  }

  Future<Result<bool>> deleteAllTodos() async {
    try {
      // Simulate a network call
      await Future.delayed(const Duration(seconds: 1));

      // Clear all todos
      await _secureStorage!.delete(key: 'todos');

      return Result.ok(true);
    } catch (e) {
      return Result.error(Exception('An error occurred: $e'));
    }
  }
}
