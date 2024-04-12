import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_state2.dart';

class CounterCubit2 extends Cubit<CounterState2> {
  CounterCubit2() : super(CounterState2.initial());

  void changeCounter(int incrementSize) {
    emit(state.copyWith(count: state.count + incrementSize));
  }
}
