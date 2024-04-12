part of 'counter_bloc.dart';

class CounterState extends Equatable {
  final int count;

  const CounterState({
    required this.count
  });

  factory CounterState.initial() => const CounterState(count: 0);

  @override
  List<Object> get props => [count];

  @override
  String toString() {
    return 'CounterState{count: $count}';
  }

  CounterState copyWith({
    int? count,
  }) {
    return CounterState(
      count: count ?? this.count,
    );
  }
}