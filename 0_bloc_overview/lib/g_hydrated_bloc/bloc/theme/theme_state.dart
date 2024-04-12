part of 'theme_bloc.dart';

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

  Map<String, dynamic> toJson() {
    return {
      'appTheme': appTheme.toJson(),
    };
  }

  factory ThemeState.fromJson(Map<String, dynamic> json) {
    return ThemeState(
      appTheme: AppTheme.fromJson(json['appTheme']),
    );
  }
}