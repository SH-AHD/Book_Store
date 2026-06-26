sealed class ProfileState {}

class ProfileInitState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileImagePickedState extends ProfileState {}

class ProfileSuccessState extends ProfileState {
  final String msg;
  ProfileSuccessState(this.msg);
}

class ProfileErrorState extends ProfileState {
  final String errorMsg;
  ProfileErrorState(this.errorMsg);
}
