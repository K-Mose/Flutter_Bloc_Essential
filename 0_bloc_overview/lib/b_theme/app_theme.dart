enum AppTheme {
  light,
  dart;

  String toJson() => name;

  static AppTheme fromJson(String json) => values.byName(json);
}