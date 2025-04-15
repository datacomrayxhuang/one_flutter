import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/screens/add_todo.dart';
import 'package:todo_app/screens/home.dart';

// GoRouter configuration
final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
final GoRouter router = GoRouter(
  navigatorKey: _navigatorKey,
  initialLocation: HomePage.routeName,
  routes: [
    GoRoute(
      path: HomePage.routeName,
      name: 'Home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: AddTodoPage.routeName,
      name: 'Add Todo',
      builder: (context, state) => const AddTodoPage(),
    ),
  ],
  redirect: (BuildContext context, GoRouterState state) {
    return null;
  },
);
