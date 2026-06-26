import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/helpers/app_validator.dart';
import 'package:bookia/core/helpers/navigation.dart';
import 'package:bookia/core/widgets/app_text_field.dart';
import 'package:bookia/core/widgets/body_view.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class UpdatePasswordScreen extends StatelessWidget {
  const UpdatePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoadingState) {
          showLoadingDialog(context);
        } else if (state is ProfileErrorState) {
          popPage(context);
          showMsgDialog(context, state.errorMsg);
        } else if (state is ProfileSuccessState) {
          popPage(context);
          showMsgDialog(context, state.msg, DialogType.success);
          popPage(context);
        }
      },
      builder: (context, state) {
        var cubit = context.read<ProfileCubit>();
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: GestureDetector(
              onTap: () {
                popPage(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPic(path: AppAssets.backSvg),
              ),
            ),
            centerTitle: true,
            title: const Text('Change Password'),
          ),
          body: BodyView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _formBuilder(context),
                Spacer(),
                MainButton(
                  text: "Update Password",
                  onPressed: () {
                    cubit.updatePassword(
                      currentPassword: cubit.currentPasswordController.text,
                      newPassword: cubit.newPasswordController.text,
                      newPasswordConfirmation:
                          cubit.confirmNewPasswordController.text,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _formBuilder(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        var cubit = context.read<ProfileCubit>();

        return BodyView(
          child: Form(
            key: cubit.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextField(
                  isPass: true,
                  controller: cubit.currentPasswordController,
                  hintText: "Current Password",
                  validator: AppValidators.validatePassword,
                  keyboardType: TextInputType.visiblePassword,
                ),
                Gap(12),
                AppTextField(
                  isPass: true,
                  controller: cubit.newPasswordController,
                  hintText: "New Password",
                  keyboardType: TextInputType.visiblePassword,
                  validator: AppValidators.validatePassword,
                ),
                Gap(12),
                AppTextField(
                  isPass: true,
                  controller: cubit.confirmNewPasswordController,
                  hintText: "Confirm New Password",
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) =>
                      AppValidators.validatePasswordConfirmation(
                        value,
                        cubit.newPasswordController.text,
                      ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
