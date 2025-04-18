part of 'home_bloc.dart';

sealed class HomeEvent {
  const HomeEvent();
}

class HomeFetchTodosRequested extends HomeEvent {
  const HomeFetchTodosRequested();
}
