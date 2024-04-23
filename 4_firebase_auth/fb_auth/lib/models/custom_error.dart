class CustomError {
  final String code;
  final String message;
  final String plugin;

  const CustomError({
    required this.code,
    required this.message,
    required this.plugin,
  });

  @override
  List<Object> get props => [code, message, plugin];

  @override
  String toString() {
    return 'CustomError{code: $code, message: $message, plugin: $plugin}';
  }
}