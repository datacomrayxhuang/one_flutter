// ignore: dangling_library_doc_comments
/// Configures navigation for the to-do app using `GoRouter`.
///
/// ### Features:
/// - **Routes**:
///   - `/home`: Displays the `HomePage` with `HomeBloc` to manage the to-do list.
///   - `/add-todo`: Displays the `AddTodoPage` with `AddTodoBloc` to add a new to-do.
/// - **Global Navigator Key**: Manages navigation globally.
/// - **State Management**: Integrates `BlocProvider` for each route.
/// - **Initial Location**: Starts at `/home`.
///
/// ### Example:
/// ```dart
/// MaterialApp.router(
///   routerConfig: router,
///   title: 'To-Do App',
///   theme: ThemeData.light(),
/// );
/// ```
///
/// ### Notes:
/// - `HomeBloc` fetches todos on `HomePage` load.
/// - `AddTodoBloc` initializes in an idle state.
///
/// ### Example Navigation:
/// ```dart
/// context.go(HomePage.routeName); // Navigate to Home
/// context.push(AddTodoPage.routeName); // Push to Add To-Do
/// ```

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/repository/todo_repository.dart';
import 'package:todo_app/screens/add_todo.dart';
import 'package:todo_app/screens/home.dart';
import 'package:todo_app/blocs/add_todo/add_todo_bloc.dart';
import 'package:todo_app/blocs/home/home_bloc.dart';

// GoRouter configuration
final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
final GoRouter router = GoRouter(
  navigatorKey: _navigatorKey,
  initialLocation: HomePage.routeName,
  routes: [
    GoRoute(
      path: HomePage.routeName,
      name: 'Home',
      builder: (context, state) => BlocProvider<HomeBloc>(
        create: (context) => HomeBloc(
          todoRepository: context.read<TodoRepository>(),
        )..add(const HomeFetchTodosRequested()),
        child: const HomePage(),
      ),
    ),
    GoRoute(
      path: AddTodoPage.routeName,
      name: 'Add Todo',
      builder: (context, state) => BlocProvider<AddTodoBloc>(
        create: (context) => AddTodoBloc(
          todoRepository: context.read<TodoRepository>(),
        ),
        child: const AddTodoPage(),
      ),
    ),
  ],
  redirect: (BuildContext context, GoRouterState state) {
    return null;
  },
);
