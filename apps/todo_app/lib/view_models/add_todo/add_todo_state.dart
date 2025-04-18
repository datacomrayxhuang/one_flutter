part of 'add_todo_bloc.dart';

enum AddTodoStatus {
  initial,
  success,
}

@immutable
class AddTodoState extends Equatable {
  final AddTodoStatus status;
  final String title;
  final String description;
  final bool isLoading;
  final String errorMessage;

  const AddTodoState({
    this.status = AddTodoStatus.initial,
    this.title = '',
    this.description = '',
    this.isLoading = false,
    this.errorMessage = '',
  });

  static const AddTodoState initial = AddTodoState();

  AddTodoState copyWith({
    AddTodoStatus? status,
    String? title,
    String? description,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AddTodoState(
      status: status ?? this.status,
      title: title ?? this.title,
      description: description ?? this.description,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [status, title, description, isLoading, errorMessage];

  bool get hasClearButton =>
      status == AddTodoStatus.initial &&
      !isLoading &&
      (title.isNotEmpty || description.isNotEmpty);
}
