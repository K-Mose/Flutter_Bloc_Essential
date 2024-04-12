part of 'counter_bloc.dart';

class CounterState extends Equatable {
  final int counter;

  factory CounterState.initial() => const CounterState(counter: 0);

  @override
  List<Object> get props => [counter];

//<editor-fold desc="Data Methods">
  const CounterState({
    required this.counter,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CounterState &&
          runtimeType == other.runtimeType &&
          counter == other.counter);

  @override
  int get hashCode => counter.hashCode;

  @override
  String toString() {
    return 'CounterState{' + ' counter: $counter,' + '}';
  }

  CounterState copyWith({
    int? counter,
  }) {
    return CounterState(
      counter: counter ?? this.counter,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'counter': counter,
    };
  }

  factory CounterState.fromJson(Map<String, dynamic> json) {
    return CounterState(
      counter: json['counter'] as int,
    );
  }

//</editor-fold>
}
