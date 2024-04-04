part of 'color_cubit.dart';

class ColorState extends Equatable {
  final Color color;

  const ColorState({
    required this.color,
  });
  
  factory ColorState.initial() => const ColorState(color: Colors.red);

  @override
  String toString() {
    return 'ColorState{color: $color}';
  }

  @override
  List<Object> get props => [color];

  ColorState copyWith({
    Color? color,
  }) {
    return ColorState(
      color: color ?? this.color,
    );
  }
}