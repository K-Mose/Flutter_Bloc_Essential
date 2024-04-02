part of 'theme_bloc.dart';

sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ChangeThemeEvent extends ThemeEvent {
  // Payload로 받을 인자를 멤버변수로 추가한다.
  final int randInt;

  const ChangeThemeEvent({
    required this.randInt,
  });

  @override
  String toString() {
    return 'ChangeThemeEvent{randInt: $randInt}';
  }

  @override
  List<Object> get props => [randInt];
}
