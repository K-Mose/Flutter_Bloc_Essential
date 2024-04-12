part of 'counter_bloc2.dart';

sealed class CounterEvent2 extends Equatable {
  const CounterEvent2();

  @override
  List<Object> get props => [];
}

// event에 property로 외부 변수 제공
class ChangeCounterEvent2 extends CounterEvent2 {
  final int incrementSize;
  const ChangeCounterEvent2({required this.incrementSize});

  @override
  List<Object> get props => [incrementSize];
}