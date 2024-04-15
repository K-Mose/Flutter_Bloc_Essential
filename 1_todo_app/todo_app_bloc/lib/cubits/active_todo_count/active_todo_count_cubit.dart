import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/cubits/todo_list/todo_list_cubit.dart';

part 'active_todo_count_state.dart';

class ActiveTodoCountCubit extends Cubit<ActiveTodoCountState> {
  // 리스트의 항목들을 확인해야하기 때문에 todoListCubit이 필요
  final TodoListCubit todoListCubit;
  // constructor에 초기 값을 설정을 위해 사용
  final int initialActiveTodoCount;

  late final StreamSubscription todoListSubscription;

  ActiveTodoCountCubit({
    required this.initialActiveTodoCount,
    required this.todoListCubit,
    // initial factory를 수정해서 사용 가능
  // }) : super(ActiveTodoCountState.initial(initialActiveTodoCount)) {
  }) : super(ActiveTodoCountState(activeTodoCount: initialActiveTodoCount)) {
    // listen에서는 변경 뒤에 콜백 값으로 업데이트 되기 때문에 초기 값이 제대로 안들어감
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
