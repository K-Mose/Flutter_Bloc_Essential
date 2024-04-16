import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/blocs/blocs.dart';
import 'package:todo_app/models/todo_model.dart';

part 'filtered_todos_event.dart';
part 'filtered_todos_state.dart';

class FilteredTodosBloc extends Bloc<FilteredTodosEvent, FilteredTodosState> {
  late final StreamSubscription todoListSubscription;
  late final StreamSubscription todoFilterSubscription;
  late final StreamSubscription todoSearchSubscription;

  final List<Todo> initialTodos;

  final TodoListBloc todoListBloc;
  final TodoFilterBloc todoFilterBloc;
  final TodoSearchBloc todoSearchBloc;

  FilteredTodosBloc({
    required this.initialTodos,
    required this.todoListBloc,
    required this.todoFilterBloc,
    required this.todoSearchBloc,
  }) : super(FilteredTodosState.initial(todos: initialTodos)) {
    todoListSubscription = todoListBloc.stream.listen((event) { setFilteredTodos();});
    todoFilterSubscription = todoFilterBloc.stream.listen((event) { setFilteredTodos();});
    todoSearchSubscription = todoSearchBloc.stream.listen((event) { setFilteredTodos();});

    on<CalculatedFilteredTodosEvent>((event, emit) {
      emit(state.copyWith(filteredTodos: event.filteredTodos));
    });
  }

  void setFilteredTodos() {
    List<Todo> _filteredTodos;

    switch (todoFilterBloc.state.filter) {
      case Filter.active:
        _filteredTodos = todoListBloc.state.todos
            .where((todo) => !todo.completed)
            .toList();
        break;
      case Filter.completed:
        _filteredTodos = todoListBloc.state.todos
            .where((todo) => todo.completed)
            .toList();
        break;
      case Filter.all:
      default:
        _filteredTodos = todoListBloc.state.todos;
    }

    if (todoSearchBloc.state.searchTerm.isNotEmpty) {
      _filteredTodos = _filteredTodos
          .where((todo) => todo.desc
          .toLowerCase()
          .contains(todoSearchBloc.state.searchTerm.toLowerCase()))
          .toList();
    }

    add(CalculatedFilteredTodosEvent(filteredTodos: _filteredTodos));
  }

  @override
  Future<void> close() {
    todoListSubscription.cancel();
    todoSearchSubscription.cancel();
    todoFilterSubscription.cancel();
    return super.close();
  }
}
