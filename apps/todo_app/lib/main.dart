import 'package:flutter/material.dart';
import 'package:todo_app/app/app.dart';

/// The entry point of the to-do application.
///
/// This file initializes the app and runs the `TodoApp` widget.
///
/// ### Features:
/// - **App Initialization**: Prepares the app for execution.
/// - **Runs the App**: Calls `runApp` to launch the `TodoApp` widget.
///
/// ### Dependencies:
/// - `TodoApp`: The root widget of the application, defined in the `app.dart` file.
///
/// ### Example:
/// ```dart
/// Future<void> main() async {
///   runApp(const TodoApp());
/// }
/// ```
///
/// ### Notes:
/// - The `main` function is asynchronous to allow for any future asynchronous initialization logic.
/// - The `TodoApp` widget is the starting point of the app's widget tree.
Future<void> main() async {
  runApp(const TodoApp());
}
