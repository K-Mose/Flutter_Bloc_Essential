import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_state.dart';

// Cuibit 클래스 안에서는 상태를 나타내는 state변수와 상태를 내보내는 emit 함수를 포함한다.
class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState.initial());

  // 상태 증가 함수
  void increment() {
    emit(state.copyWith(counter: state.counter + 1));
  }
  
  void decrement() {
    emit(state.copyWith(counter: state.counter - 1));
  }
}
