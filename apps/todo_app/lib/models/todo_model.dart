import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;

/// The `TodoModel` class represents a to-do item in the application.
///
/// This model is immutable and extends `Equatable` to enable value-based equality checks.
/// It provides methods for JSON serialization, deserialization, and creating modified copies
/// of the to-do item using the `copyWith` method.
///
/// ### Properties:
/// - `id` (String): A unique identifier for the to-do item.
/// - `title` (String): The title of the to-do item.
/// - `description` (String): A detailed description of the to-do item.
/// - `isCompleted` (bool): Indicates whether the to-do item is completed. Defaults to `false`.
///
/// ### Features:
/// - **Immutability**: The class is immutable, ensuring that the state of a to-do item cannot be modified directly.
/// - **JSON Serialization**:
///   - `toJson()`: Converts the `TodoModel` instance into a JSON map.
///   - `fromJson(Map<String, dynamic> json)`: Creates a `TodoModel` instance from a JSON map.
/// - **Copying**:
///   - `copyWith({String? title, String? description, bool? isCompleted})`: Creates a new `TodoModel` instance with updated values while preserving the original `id`.
///
/// ### Example Usage:
/// ```dart
/// // Creating a new to-do item
/// const todo = TodoModel(
///   id: '1',
///   title: 'Buy groceries',
///   description: 'Milk, eggs, bread, and fruits',
/// );
///
/// // Converting to JSON
/// final json = todo.toJson();
/// print(json); // Output: {id: 1, title: Buy groceries, description: Milk, eggs, bread, and fruits, isCompleted: false}
///
/// // Creating a to-do item from JSON
/// final newTodo = TodoModel.fromJson(json);
/// print(newTodo.title); // Output: Buy groceries
///
/// // Creating a modified copy
/// final updatedTodo = todo.copyWith(isCompleted: true);
/// print(updatedTodo.isCompleted); // Output: true
/// ```
///
/// ### Notes:
/// - The `id` property is immutable and cannot be modified using the `copyWith` method.
/// - The `isCompleted` property defaults to `false` if not explicitly provided during initialization or deserialization.
///
/// ### Equality:
/// - The class overrides `props` from `Equatable` to enable value-based equality checks.
/// - Two `TodoModel` instances are considered equal if their `id`, `title`, `description`, and `isCompleted` properties are the same.
@immutable
class TodoModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;

  const TodoModel({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    };
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  // Does not allow modification of the id
  TodoModel copyWith({
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return TodoModel(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        isCompleted,
      ];
}
