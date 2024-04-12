import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState.initial()) {
    // on 함수는 Event를 타입으로 받고 이벤트를 구현함
    // 처리 로직이 간단할 경우 익명함수 안애서 사용
    on<CounterIncrementPressedEvent>((event, emit) {
      emit(state.copyWith(counter: state.counter + 1));
    });

    // 로직이 복잡할 경우 외부에서 정의
    on<CounterDecrementPressedEvent>(_decrementCounter);

  }

  void _decrementCounter(
    CounterDecrementPressedEvent event,
    Emitter<CounterState> emit,
  ) {
    emit(state.copyWith(counter: state.counter - 1));
  }
}
