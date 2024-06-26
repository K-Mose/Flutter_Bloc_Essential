part of 'todo_filter_bloc.dart';

class TodoFilterState extends Equatable {
  final Filter filter;
  const TodoFilterState({required this.filter});

  factory TodoFilterState.initial() {
    return TodoFilterState(filter: Filter.all);
  }

  @override
  List<Object> get props => [filter];

  @override
  String toString() {
    return 'TodoFilterState{filter: $filter}';
  }

  TodoFilterState copyWith({
    Filter? filter,
  }) {
    return TodoFilterState(
      filter: filter ?? this.filter,
    );
  }
}
