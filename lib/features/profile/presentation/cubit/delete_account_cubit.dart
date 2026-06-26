import 'package:bookia/features/profile/data/repo/profile_repo.dart';
import 'package:bookia/features/profile/presentation/cubit/delete_account_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit() : super(DeleteAccountInitState());

  Future<void> deleteAccount({required String currentPassword}) async {
    emit(DeleteAccountLoadingState());
    try {
      final deleted = await ProfileRepo.deleteAccount(
        currentPassword: currentPassword,
      );
      if (deleted) {
        emit(DeleteAccountSuccessState());
      } else {
        emit(DeleteAccountErrorState("Something went wrong. Please try again."));
      }
    } catch (e) {
      final errorMsg = e.toString().replaceFirst('Exception: ', '');
      emit(DeleteAccountErrorState(errorMsg));
    }
  }
}
