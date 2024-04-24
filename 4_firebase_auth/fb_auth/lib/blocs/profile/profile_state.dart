part of 'profile_cubit.dart';

enum ProfileStatus {
  initial,
  loading,
  loaded,
  error,
}

class ProfileState extends Equatable {
  const ProfileState({
    required this.profileStatus,
    required this.user,
    required this.error,
  });

  final ProfileStatus profileStatus;
  final User user;
  final CustomError error;

  factory ProfileState.initial() => ProfileState(
    profileStatus: ProfileStatus.initial,
    user: User.initial(),
    error: const CustomError()
  );

  @override
  List<Object> get props => [profileStatus, user, error];

  @override
  String toString() {
    return 'ProfilState{profileStatus: $profileStatus, user: $user, error: $error}';
  }

  ProfileState copyWith({
    ProfileStatus? profileStatus,
    User? user,
    CustomError? error,
  }) {
    return ProfileState(
      profileStatus: profileStatus ?? this.profileStatus,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }
}
