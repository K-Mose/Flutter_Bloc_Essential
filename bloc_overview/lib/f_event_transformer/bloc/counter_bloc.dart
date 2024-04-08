import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class TransformerCounterBloc extends Bloc<CounterEvent, CounterState> {
  TransformerCounterBloc() : super(CounterState.initail()) {
    /*on<CounterIncrementPressed>(
        _handleIncrementCounterEvent,
        transformer: restartable()
    );

    on<CounterDecrementPressed>(
      _handleDecrementCounterEvent,
      transformer: restartable()
    );*/
    // 모든 이벤트를 동시에 처리하는 핸들러
    // 두 이벤트의 상위 클래스를 타입으로 지정
    on<CounterEvent>(
      (event, emit) async {
        if (event is CounterIncrementPressed) {
          await _handleIncrementCounterEvent(event, emit);
        } else if (event is CounterDecrementPressed) {
          await _handleDecrementCounterEvent(event, emit);
        }
      },
      transformer: restartable()
    );
  }

  Future<void> _handleIncrementCounterEvent(event, emit) async {
    await Future.delayed(const Duration(seconds: 4));
    emit(state.copyWith(counter: state.counter + 1));
  }

  Future<void> _handleDecrementCounterEvent(event, emit) async {
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(counter: state.counter - 1));
  }
}
