import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/cubits/todo_filter/todo_filter_cubit.dart';
import 'package:todo_app/cubits/todo_list/todo_list_cubit.dart';
import 'package:todo_app/cubits/todo_search/todo_search_cubit.dart';
import 'package:todo_app/models/todo_model.dart';

part 'filtered_todos_state.dart';

class FilteredTodosCubit extends Cubit<FilteredTodosState> {
  late final StreamSubscription todoListSubscription;
  late final StreamSubscription todoFilterSubscription;
  late final StreamSubscription todoSearchSubscription;

  // Filtered TodoList를 얻기 위해서는 TodoList와 2가지 필터 조건이 필요함
  final TodoListCubit todoListCubit;
  final TodoFilterCubit todoFilterCubit;
  final TodoSearchCubit todoSearchCubit;

  FilteredTodosCubit({
    required this.todoListCubit,
    required this.todoFilterCubit,
    required this.todoSearchCubit,
  }) : super(FilteredTodosState.initial()) {
    // setFilteredTodos를 아래 세 상태가 업데이트 될 때마다 실행시킴
    todoListSubscription = todoListCubit.stream.listen((event) {
      setFilteredTodos();
    });
    todoFilterSubscription = todoFilterCubit.stream.listen((event) {
      setFilteredTodos();
    });
    todoSearchSubscription = todoSearchCubit.stream.listen((event) {
      setFilteredTodos();
    });
  }

  void setFilteredTodos() {
    List<Todo> _filteredTodos;

    switch (todoFilterCubit.state.filter) {
      case Filter.active:
        _filteredTodos = todoListCubit.state.todos
            .where((todo) => !todo.completed)
            .toList();
        break;
      case Filter.completed:
        _filteredTodos = todoListCubit.state.todos
            .where((todo) => todo.completed)
            .toList();
        break;
      case Filter.all:
      default:
        _filteredTodos = todoListCubit.state.todos;
    }

    if (todoSearchCubit.state.searchTerm.isNotEmpty) {
      _filteredTodos = _filteredTodos
        .where((todo) => todo.desc
          .toLowerCase()
          .contains(todoSearchCubit.state.searchTerm.toLowerCase()))
        .toList();
    }

    emit(state.copyWith(filteredTodos:_filteredTodos));
  }

  @override
  Future<void> close() {
    todoListSubscription.cancel();
    todoSearchSubscription.cancel();
    todoFilterSubscription.cancel();
    return super.close();
  }
}
