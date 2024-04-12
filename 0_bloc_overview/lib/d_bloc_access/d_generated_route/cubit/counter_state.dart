part of 'counter_cubit.dart';

class CounterState extends Equatable {
  final int counter;
  const CounterState({
    required this.counter
  });

  factory CounterState.initial() => const CounterState(counter: 1);

  @override
  List<Object> get props => [counter];

  @override
  String toString() {
    return 'CounterState{counter: $counter}';
  }

  CounterState copyWith({
    int? counter,
  }) {
    return CounterState(
      counter: counter ?? this.counter,
    );
  }
}