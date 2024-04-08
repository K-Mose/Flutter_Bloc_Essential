import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class HydratedCounterBloc extends Bloc<CounterEvent, CounterState> with HydratedMixin {
  HydratedCounterBloc() : super(CounterState.initial()) {
    hydrate();

    on<CounterEvent>(
            (event, emit) async {
          if (event is CounterIncrementPressed) {
            await _handleIncrementCounterEvent(event, emit);
          } else if (event is CounterDecrementPressed) {
            await _handleDecrementCounterEvent(event, emit);
          }
        },
    );
  }

  Future<void> _handleIncrementCounterEvent(event, emit) async {
    emit(state.copyWith(counter: state.counter + 1));
  }

  Future<void> _handleDecrementCounterEvent(event, emit) async {
    emit(state.copyWith(counter: state.counter - 1));
  }

  @override
  CounterState? fromJson(Map<String, dynamic> json) {
    print("Counter From Storage: $json");
    final counterState = CounterState.fromJson(json);
    print("CounterState: $counterState");
    return counterState;
  }

  @override
  Map<String, dynamic>? toJson(CounterState state) {
    print("CounterState to Storage: $state");
    final counterJson = state.toJson();
    print("CounterJson: $counterJson");
    return counterJson;
  }
}
