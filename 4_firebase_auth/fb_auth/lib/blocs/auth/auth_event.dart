part of 'auth_bloc.dart';

sealed

class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthEventChangeAuthState extends AuthEvent {
  final fbAuth.User? user;

  const AuthEventChangeAuthState({
    required this.user
  });

  @override
  List<Object?> get props => [user];
}

class AuthEventSignoutRequest extends AuthEvent {}