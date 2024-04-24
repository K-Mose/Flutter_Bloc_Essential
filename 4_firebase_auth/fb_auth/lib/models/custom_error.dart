//  FirebaseException({
//     required this.plugin,
//     this.message,
//     String? code,
//     this.stackTrace,
//     // ignore: unnecessary_this
//   }) : this.code = code ?? 'unknown';
class CustomError {
  final String code;
  final String message;
  final String plugin;

  const CustomError({
    this.code = '',
    this.message = '',
    this.plugin = '',
  });

  @override
  List<Object> get props => [code, message, plugin];

  @override
  String toString() {
    return 'CustomError{code: $code, message: $message, plugin: $plugin}';
  }
}