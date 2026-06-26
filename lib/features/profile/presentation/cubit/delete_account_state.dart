sealed class DeleteAccountState {}

class DeleteAccountInitState extends DeleteAccountState {}

class DeleteAccountLoadingState extends DeleteAccountState {}

class DeleteAccountSuccessState extends DeleteAccountState {}

class DeleteAccountErrorState extends DeleteAccountState {
  final String errorMsg;
  DeleteAccountErrorState(this.errorMsg);
}
