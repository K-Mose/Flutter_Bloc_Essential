part of 'active_todo_count_cubit.dart';

class ActiveTodoCountState extends Equatable {
  final int activeTodoCount;

  const ActiveTodoCountState({
    required this.activeTodoCount,
  });


  factory ActiveTodoCountState.initial() =>
  // TodoListState에 3개의 초기 Todo가 있으므로 0은 정확한 초기값이 아님  
      const ActiveTodoCountState(activeTodoCount: 0);

  @override
  List<Object> get props => [activeTodoCount];

  @override
  String toString() {
    return 'ActiveTodoCountState{activeTodoCount: $activeTodoCount}';
  }

  ActiveTodoCountState copyWith({
    int? activeTodoCount,
  }) {
    return ActiveTodoCountState(
      activeTodoCount: activeTodoCount ?? this.activeTodoCount,
    );
  }
}