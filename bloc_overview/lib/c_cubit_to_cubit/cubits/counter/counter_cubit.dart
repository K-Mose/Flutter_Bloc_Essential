import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_overview/c_cubit_to_cubit/cubits/color/color_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  int incrementSize = 1;

  // ColorCubit을 읽어오기위한 인스턴스
  final ColorCubit colorCubit;
  // StreamSubscription은 자동으로 dispose 되지 않기 때문에 변수를 추가해서 수동으로 dispose 해줌
  late final StreamSubscription colorSubscription;

  CounterCubit({required this.colorCubit}) : super(CounterState.initial()) {
    // listen은 해당 State타입을 받고 void를 반환하는 콜백 함수를 받으며
    // 상태가 업데이트 될 때 마다 콜백이 실행이 됨
    colorSubscription = colorCubit.stream.listen((ColorState colorState) {
      // listener에서는 상태 변화에 따라 콜백이 실행되므로 initial 상태는 읽지 않음
      // 여기서는 incrementSize의 초기 값을 colorState의 초기 값에 일치하는 값을 설정
      if (colorState.color == Colors.red) {
        incrementSize = 1;
      } else if (colorState.color == Colors.green) {
        incrementSize = 10;
      } else if (colorState.color == Colors.blue) {
        incrementSize = 100;
      } else if (colorState.color == Colors.black) {
        incrementSize = -100;
      }
      print("increment Size :: $incrementSize");
    });
  }

  void changeCounter() {
    print("changeCounter :: ${state.count + incrementSize}");
    emit(state.copyWith(count: state.count + incrementSize));
  }

  @override
  Future<void> close() {
    // 수동으로 취소
    colorSubscription.cancel();
    return super.close();
  }
}
