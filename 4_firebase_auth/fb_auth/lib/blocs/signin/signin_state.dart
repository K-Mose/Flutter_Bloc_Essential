part of 'signin_cubit.dart';

enum SignInStatus {
  initial,
  submitting,
  success,
  error,
}

class SignInState extends Equatable {
  const SignInState({
    required this.signInStatus,
    required this.error,
  });

  final SignInStatus signInStatus;
  final CustomError error;

  factory SignInState.initial() =>
      SignInState(signInStatus: SignInStatus.initial, error: CustomError());

  @override
  List<Object> get props => [signInStatus, error];

  @override
  String toString() {
    return 'SignInState{signInStatus: $signInStatus, error: $error}';
  }

  SignInState copyWith({
    SignInStatus? signInStatus,
    CustomError? error,
  }) {
    return SignInState(
      signInStatus: signInStatus ?? this.signInStatus,
      error: error ?? this.error,
    );
  }
}
