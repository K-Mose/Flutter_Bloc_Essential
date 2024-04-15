import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/cubits/todo_filter/todo_filter_cubit.dart';
import 'package:todo_app/cubits/todo_list/todo_list_cubit.dart';
import 'package:todo_app/cubits/todo_search/todo_search_cubit.dart';
import 'package:todo_app/models/todo_model.dart';

part 'filtered_todos_state.dart';

class FilteredTodosCubit extends Cubit<FilteredTodosState> {
  final List<Todo> initialTodos;

  FilteredTodosCubit({
    required this.initialTodos,
  }) : super(FilteredTodosState.initial(todos: initialTodos));

  void setFilteredTodos(
    Filter filter,
    List<Todo> todos,
    String searchTerm
  ) {
    List<Todo> _filteredTodos;

    switch (filter) {
      case Filter.active:
        _filteredTodos = todos
            .where((todo) => !todo.completed)
            .toList();
        break;
      case Filter.completed:
        _filteredTodos = todos
            .where((todo) => todo.completed)
            .toList();
        break;
      case Filter.all:
      default:
        _filteredTodos = todos;
    }

    if (searchTerm.isNotEmpty) {
      _filteredTodos = _filteredTodos
        .where((todo) => todo.desc
          .toLowerCase()
          .contains(searchTerm.toLowerCase()))
        .toList();
    }

    emit(state.copyWith(filteredTodos:_filteredTodos));
  }
}
