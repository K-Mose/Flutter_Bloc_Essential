import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_event2.dart';
part 'counter_state2.dart';

// Cubit과 동일하되 Function에서 Event 처리로 변경되었다.
class CounterBloc2 extends Bloc<CounterEvent2, CounterState2> {
  int incrementSize = 1;
  
  CounterBloc2() : super(CounterState2.initial()) {


    // event에
    on<ChangeCounterEvent2>((event, emit) {
      emit(state.copyWith(count: state.count + event.incrementSize));
    },);
  }
}