import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/cubits/todo_list/todo_list_cubit.dart';

part 'active_todo_count_state.dart';

class ActiveTodoCountCubit extends Cubit<ActiveTodoCountState> {
  // 리스트의 항목들을 확인해야하기 때문에 todoListCubit이 필요
  final TodoListCubit todoListCubit;

  late final StreamSubscription todoListSubscription;

  ActiveTodoCountCubit({
    required this.todoListCubit,
  }) : super(ActiveTodoCountState.initial()) {
    todoListSubscription = todoListCubit.stream.listen((TodoListState todoListState) {
      print("todoListState: $todoListState");

      final int currentActiveTodoCount = todoListState.todos
          .where((todo) => !todo.completed)
          .toList()
          .length;

      emit(state.copyWith(activeTodoCount: currentActiveTodoCount));
    });
  }


  @override
  Future<void> close() {
    todoListSubscription.cancel();
    return super.close();
  }
}
