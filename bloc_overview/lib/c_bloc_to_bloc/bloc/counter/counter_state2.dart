part of 'counter_bloc2.dart';

class CounterState2 extends Equatable {
  final int count;

  const CounterState2({
    required this.count
  });

  factory CounterState2.initial() => const CounterState2(count: 0);

  @override
  List<Object> get props => [count];

  @override
  String toString() {
    return 'CounterState{count: $count}';
  }

  CounterState2 copyWith({
    int? count,
  }) {
    return CounterState2(
      count: count ?? this.count,
    );
  }
}