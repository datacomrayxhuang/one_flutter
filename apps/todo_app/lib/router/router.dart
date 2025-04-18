import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/repository/todo_repository.dart';
import 'package:todo_app/screens/add_todo.dart';
import 'package:todo_app/screens/home.dart';
import 'package:todo_app/view_models/add_todo/add_todo_bloc.dart';
import 'package:todo_app/view_models/home/home_bloc.dart';

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
