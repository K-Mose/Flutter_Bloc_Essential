import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fb_auth/models/custom_error.dart';
import 'package:fb_auth/repositories/auth_repository.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository authRepository;

  SignUpCubit({required this.authRepository}) : super(SignUpState.initial());

  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(signupStatus: SignUpStatus.submitting));

    try {
      await authRepository.signup(name: name, email: email, password: password);
      emit(state.copyWith(signupStatus: SignUpStatus.success));
    } on CustomError catch(e) {
      emit(state.copyWith(
        signupStatus: SignUpStatus.error,
        error: e
      ));
    }
  }
}
