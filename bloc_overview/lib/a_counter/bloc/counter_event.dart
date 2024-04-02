part of 'counter_bloc.dart';

sealed class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object> get props => [];
}

// Bloc에서 사용할 이벤트 등록
class CounterIncrementPressedEvent extends CounterEvent{}

class CounterDecrementPressedEvent extends CounterEvent{}