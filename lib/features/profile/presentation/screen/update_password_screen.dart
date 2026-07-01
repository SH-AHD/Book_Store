import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/helpers/app_validator.dart';
import 'package:bookia/core/helpers/navigation.dart';
import 'package:bookia/core/widgets/app_back_btn.dart';
import 'package:bookia/core/widgets/app_text_field.dart';
import 'package:bookia/core/widgets/body_view.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_states.dart';
import 'package:bookia/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
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
           leading:Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppBackBtn(),
            ),
            centerTitle: true,
            title: Text(LocaleKeys.change_password.tr()),
          ),
          body: BodyView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _formBuilder(context),
                Spacer(),
                MainButton(
                  text: LocaleKeys.update_password_btn.tr(),
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
                  hintText: LocaleKeys.current_password.tr(),
                  validator: AppValidators.validatePassword,
                  keyboardType: TextInputType.visiblePassword,
                ),
                Gap(12),
                AppTextField(
                  isPass: true,
                  controller: cubit.newPasswordController,
                  hintText: LocaleKeys.new_password_field.tr(),
                  keyboardType: TextInputType.visiblePassword,
                  validator: AppValidators.validatePassword,
                ),
                Gap(12),
                AppTextField(
                  isPass: true,
                  controller: cubit.confirmNewPasswordController,
                  hintText: LocaleKeys.confirm_new_password.tr(),
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
