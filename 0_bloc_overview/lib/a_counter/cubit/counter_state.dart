part of 'counter_cubit.dart';


// State를 class로 만들면 일관성 유지와 타입 충돌을 피할 수 있다.
// 타입 충돌은 .of(context)를 통해서 상위 위젯트리로 올라가면서 타입을 찾을 때
// 중복되는 타입이 존재하면 멀리 있는 위젯트리상의 타입은 가져올 수 없다.
// State를 클래스로 지정하면 위 충돌을 피하여 타입을 가져올 수 있다.
class CounterState extends Equatable {
  final int counter;

  const CounterState({
    required this.counter,
  });

  factory CounterState.initial() => const CounterState(counter: 0);

  @override
  String toString() {
    return '$counter';
  }

  @override
  List<Object> get props => [counter];

  CounterState copyWith({
    int? counter,
  }) {
    return CounterState(
      counter: counter ?? this.counter,
    );
  }
}

// // 사용자에게 보여줄 initial state
// final
// class CounterInitial extends CounterState {
// @override
// List<Object> get props => [];
// }
