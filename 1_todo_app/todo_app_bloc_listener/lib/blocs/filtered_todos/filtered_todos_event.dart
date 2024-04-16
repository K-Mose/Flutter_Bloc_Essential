part of 'filtered_todos_bloc.dart';

sealed

class FilteredTodosEvent extends Equatable {
  const FilteredTodosEvent();

  @override
  List<Object> get props => [];
}

class CalculatedFilteredTodosEvent extends FilteredTodosEvent {
  final List<Todo> filteredTodos;

  const CalculatedFilteredTodosEvent({
    required this.filteredTodos,
  });

  @override
  String toString() {
    return 'CalculatedFilteredTodosEvent{filteredTodos: $filteredTodos}';
  }

  @override
  List<Object> get props => [filteredTodos];
}
