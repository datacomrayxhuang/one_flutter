import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/repository/todo_repository.dart';
import 'package:todo_app/router/router.dart';
import 'package:ui_elements/styles/color_constants.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /// Disable landscape mode in mobile
    if (!kIsWeb) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    }

    return RepositoryProvider(
      create: (context) => TodoRepository(),
      child: MaterialApp.router(
        title: 'Todo App',
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: kDefaultTheme,
      ),
    );
  }
}
