part of 'counter_bloc.dart';

sealed class CounterEvent extends Equatable {

  @override
  List<Object> get props => [];
}

class CounterIncrementPressed extends CounterEvent {}
class CounterDecrementPressed extends CounterEvent {}
