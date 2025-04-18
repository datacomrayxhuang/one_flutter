part of 'action_todo_bloc.dart';

enum ActionTodoStateStatus {
  initial,
  loading,
  success,
}

@immutable
class ActionTodoState extends Equatable {
  final ActionTodoStateStatus status;
  final String errorMessage;
  final String actionCompletionMessage;
  final bool hasActed;

  const ActionTodoState({
    this.status = ActionTodoStateStatus.initial,
    this.errorMessage = '',
    this.actionCompletionMessage = '',
    this.hasActed = false,
  });

  static const ActionTodoState initial = ActionTodoState();

  ActionTodoState copyWith({
    ActionTodoStateStatus? status,
    String? errorMessage,
    String? actionCompletionMessage,
    bool? hasActed,
  }) {
    return ActionTodoState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      actionCompletionMessage:
          actionCompletionMessage ?? this.actionCompletionMessage,
      hasActed: hasActed ?? this.hasActed,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        actionCompletionMessage,
        hasActed,
      ];
}
