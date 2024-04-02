part of 'theme_bloc.dart';

enum AppTheme {
  light,
  dart
}

class ThemeState {
  final AppTheme appTheme;

  factory ThemeState.initial() => ThemeState();

  const ThemeState({
    this.appTheme = AppTheme.light,
  });

  ThemeState copyWith({
    AppTheme? appTheme,
  }) {
    return ThemeState(
      appTheme: appTheme ?? this.appTheme,
    );
  }

  @override
  String toString() {
    return 'ThemeState{appTheme: $appTheme}';
  }

  @override
  List<Object> get props => [appTheme];
}