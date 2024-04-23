part of 'auth_bloc.dart';

enum AuthStatus {
  unknown,
  authenticated,
  unauthenticated
}

class AuthState extends Equatable {
  const AuthState({
    required this.authStatus,
    this.user,
  });

  final AuthStatus authStatus;
  final fbAuth.User? user;

  factory AuthState.unknown() =>
      const AuthState(authStatus: AuthStatus.unknown);


  @override
  String toString() {
    return 'AuthState{authStatus: $authStatus, user: $user}';
  }

  @override
  List<Object?> get props => [authStatus, user];

  AuthState copyWith({
    AuthStatus? authStatus,
    fbAuth.User? user,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      user: user ?? this.user,
    );
  }
}
