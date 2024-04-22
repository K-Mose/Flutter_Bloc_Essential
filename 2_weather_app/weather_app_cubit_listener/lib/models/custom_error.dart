class CustomError {
  final String errMsg;

  const CustomError({
    this.errMsg = '',
  });

  @override
  List<Object> get props => [errMsg];

  @override
  String toString() {
    return 'CustomError{errMsg: $errMsg}';
  }
}