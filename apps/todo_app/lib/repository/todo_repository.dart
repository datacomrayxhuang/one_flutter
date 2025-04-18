import 'dart:convert';

import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/repository/secure_storage.dart';
import 'package:todo_app/utils/result.dart';

class TodoRepository {
  static final TodoRepository _instance = TodoRepository._internal();

  factory TodoRepository() {
    return _instance;
  }

  TodoRepository._internal();

  Future<Result<List<TodoModel>>> getTodos() async {
    try {
      // Simulate a network call
      await Future.delayed(const Duration(seconds: 1));

      final String? todos = await SecureStorage().read(key: 'todos');
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
          SecureStorage().write(
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
}
