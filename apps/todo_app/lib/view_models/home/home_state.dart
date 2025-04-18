part of 'home_bloc.dart';

@immutable
class HomeState extends Equatable {
  final List<TodoModel> todos;
  final bool isLoading;
  final String errorMessage;

  const HomeState({
    this.todos = const [],
    this.isLoading = false,
    this.errorMessage = '',
  });

  static const HomeState initial = HomeState();

  @override
  List<Object?> get props => [todos, isLoading, errorMessage];

  HomeState copyWith({
    List<TodoModel>? todos,
    bool? isLoading,
    String? errorMessage,
  }) {
    return HomeState(
      todos: todos ?? this.todos,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
