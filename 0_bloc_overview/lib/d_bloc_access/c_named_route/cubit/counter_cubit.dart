import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_state.dart';

class NamedCounterCubit extends Cubit<CounterState> {
  NamedCounterCubit() : super(CounterState.initial());

  void increment() {
    emit(state.copyWith(counter: state.counter + 1));
  }
}
