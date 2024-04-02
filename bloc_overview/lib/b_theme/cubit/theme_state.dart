part of 'theme_cubit.dart';

class ThemeState {
  final AppTheme appTheme;

  factory ThemeState.initial() => const ThemeState();

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