import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/profile/data/repo/profile_repo.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_states.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitState()) {
    final user = SharedPref.getUsrInfo();
    fullNameController = TextEditingController(text: user?.name ?? "");
    phoneController = TextEditingController(
      text: user?.phone?.toString() ?? "",
    );
    cityController = TextEditingController(text: user?.city ?? "");
    addressController = TextEditingController(text: user?.address ?? "");
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final TextEditingController fullNameController;
  late final TextEditingController phoneController;
  late final TextEditingController cityController;
  late final TextEditingController addressController;
  String? imagePath;

  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  void updatePickedImage(String path) {
    imagePath = path;
    emit(ProfileImagePickedState());
  }

  Future<void> updateUserData({
    required String name,
    required String address,
    required String city,
    required String phone,
    String? imagePath,
  }) async {
    emit(ProfileLoadingState());
    try {
      final updatedUser = await ProfileRepo.updateProfile(
        name: name,
        address: address,
        city: city,
        phone: phone,
        imagePath: imagePath,
      );

      if (updatedUser != null) {
        await SharedPref.saveUsrInfo(updatedUser);
        fullNameController.text = updatedUser.name ?? "";
        phoneController.text = updatedUser.phone?.toString() ?? "";
        cityController.text = updatedUser.city ?? "";
        addressController.text = updatedUser.address ?? "";

        this.imagePath = null;
        emit(ProfileSuccessState("Updated successfully"));
      } else {
        emit(ProfileErrorState("Something went wrong"));
      }
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    emit(ProfileLoadingState());
    try {
      final updatedPassword = await ProfileRepo.updatePassword(
        current_password: currentPassword,
        new_password: newPassword,
        new_password_confirmation: newPasswordConfirmation,
      );

      if (updatedPassword != null) {
        emit(ProfileSuccessState("Updated successfully"));
      } else {
        emit(ProfileErrorState("Something went wrong"));
      }
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }

  Future<void> deleteAccount({required String currentPassword}) async {
    emit(ProfileLoadingState());
    try {
      final deleted = await ProfileRepo.deleteAccount(
        currentPassword: currentPassword,
      );

      if (deleted) {
        emit(ProfileSuccessState("Updated successfully"));
      } else {
        emit(ProfileErrorState("Something went wrong"));
      }
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }

  @override
  Future<void> close() {
    fullNameController.dispose();
    phoneController.dispose();
    cityController.dispose();
    addressController.dispose();
    return super.close();
  }
}
