import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:fb_auth/models/custom_error.dart';
import 'package:fb_auth/models/user.dart';
import 'package:fb_auth/repositories/profile_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository profileRepository;

  ProfileCubit({required this.profileRepository}) : super(ProfileState.initial());
  
  Future<void> getProfile({required String uid}) async {
    emit(state.copyWith(profileStatus: ProfileStatus.loading));
    try {
      final User user = await profileRepository.getProfile(uid: uid);
      emit(state.copyWith(user: user, profileStatus: ProfileStatus.loaded));
    } on CustomError catch (e) {
      emit(state.copyWith(
        profileStatus: ProfileStatus.error,
        error: e,
      ));
    }
  }
}
