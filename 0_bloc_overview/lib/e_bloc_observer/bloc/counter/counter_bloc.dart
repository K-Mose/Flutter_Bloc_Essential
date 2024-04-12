import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_overview/e_bloc_observer/bloc/color/color_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class ObserverCounterBloc extends Bloc<CounterEvent, CounterState> {
  int incrementSize = 1;
  final ObserverColorBloc colorBloc;
  late final StreamSubscription colorSubscription;

  ObserverCounterBloc({required this.colorBloc}) : super(CounterState.initial()) {
    colorSubscription = colorBloc.stream.listen((ColorState colorState) {
      if (colorState.color == Colors.red) {
        incrementSize = 1;
      } else if (colorState.color == Colors.green) {
        incrementSize = 10;
      } else if (colorState.color == Colors.blue) {
        incrementSize = 100;
      } else if (colorState.color == Colors.black) {
        incrementSize = -100;
        add(CounterIncrementPressedEvent());
      }
    });

    on<CounterIncrementPressedEvent>((event, emit) {
      emit(state.copyWith(counter: state.counter + incrementSize));
    },);
  }

  @override
  Future<void> close() {
    colorSubscription.cancel();
    return super.close();
  }
}
