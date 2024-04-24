part of 'signup_cubit.dart';

enum SignUpStatus {
  initial,
  submitting,
  success,
  error,
}

class SignUpState extends Equatable {
  const SignUpState({
    required this.signupStatus,
    required this.error,
  });

  final SignUpStatus signupStatus;
  final CustomError error;

  factory SignUpState.initial() =>
      const SignUpState(signupStatus: SignUpStatus.initial, error: CustomError());

  @override
  List<Object> get props => [signupStatus, error];

  @override
  String toString() {
    return 'signupState{signupStatus: $signupStatus, error: $error}';
  }

  SignUpState copyWith({
    SignUpStatus? signupStatus,
    CustomError? error,
  }) {
    return SignUpState(
      signupStatus: signupStatus ?? this.signupStatus,
      error: error ?? this.error,
    );
  }
}
