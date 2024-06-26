part of 'counter_bloc.dart';

class CounterState {
  final int counter;

  const CounterState({
    required this.counter
  });

  factory CounterState.initial() => const CounterState(counter: 0);

  CounterState copyWith({
    int? counter,
  }) {
    return CounterState(
      counter: counter ?? this.counter,
    );
  }

  @override
  String toString() {
    return 'CounterState{counter: $counter}';
  }

  @override
  List<Object> get props => [counter];
}
