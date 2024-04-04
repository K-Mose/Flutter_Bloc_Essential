import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_overview/c_bloc_to_bloc/bloc/color/color_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'counter_event.dart';
part 'counter_state.dart';

// Cubit과 동일하되 Function에서 Event 처리로 변경되었다.
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  int incrementSize = 1;
  final ColorBloc colorBloc;
  late final StreamSubscription colorSubscription;
  
  CounterBloc({required this.colorBloc}) : super(CounterState.initial()) {
    colorSubscription = colorBloc.stream.listen((ColorState colorState) {
      if (colorState.color == Colors.red) {
        incrementSize = 1;
      } else if (colorState.color == Colors.green) {
        incrementSize = 10;
      } else if (colorState.color == Colors.blue) {
        incrementSize = 100;
      } else if (colorState.color == Colors.black) {
        incrementSize = -100;
        add(ChangeCounterEvent());
      }
      print("increment Size :: $incrementSize");
    });

    on<ChangeCounterEvent>((event, emit) {
      emit(state.copyWith(count: state.count + incrementSize));
    },);
  }

  @override
  Future<void> close() {
    // 수동으로 취소
    colorSubscription.cancel();
    return super.close();
  }
}