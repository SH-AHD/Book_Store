import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/app_text_field.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/features/profile/presentation/cubit/delete_account_cubit.dart';
import 'package:bookia/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

enum DialogType { error, success, warning }

void showMsgDialog(
  BuildContext context,
  String message, [
  DialogType type = DialogType.error,
]) {
  Color color;
  IconData icon;
  switch (type) {
    case DialogType.error:
      color = AppColors.redColor;
      icon = Icons.error;
      break;
    case DialogType.success:
      color = Colors.green;
      icon = Icons.check_circle;
      break;
    case DialogType.warning:
      color = Colors.amber;
      icon = Icons.warning;
      break;
  }
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(10),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: color,
      content: Row(
        children: [
          Icon(icon, color: AppColors.whiteColor, size: 20),
          const Gap(10),
          Expanded(
            child: Text(message, maxLines: 5, overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    ),
  );
}

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Center(child: Lottie.asset(AppAssets.loadingJson)),
  );
}

void showLogoutConfirmDialog(BuildContext ctx, VoidCallback onConfirm) {
  showDialog(
    context: ctx,
    barrierDismissible: false,
    builder: (dialogCtx) => AlertDialog(
      backgroundColor: AppColors.latteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        LocaleKeys.logout.tr(),
        style: TextStyles.font16.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.redColor,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.logout_message.tr(),
            style: TextStyles.font14.copyWith(
              color: AppColors.darkGrayColor,
              height: 1.5,
            ),
          ),
          const Gap(16),
          SizedBox(
            width: MediaQuery.of(dialogCtx).size.width * 0.6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MainButton(
                  text: LocaleKeys.logout.tr(),
                  width: MediaQuery.of(dialogCtx).size.width * 0.3,
                  color: AppColors.redColor,
                  onPressed: () {
                    Navigator.of(dialogCtx).pop();
                    onConfirm();
                  },
                ),
                const Gap(10),
                MainButton(
                  text: LocaleKeys.cancel.tr(),
                  width: MediaQuery.of(dialogCtx).size.width * 0.25,
                  color: AppColors.primaryColor,
                  textColor: AppColors.whiteColor,
                  borderColor: AppColors.semiWhiteBorderColor,
                  onPressed: () => Navigator.of(dialogCtx).pop(),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

void showDeleteConfirmDialog(
  BuildContext ctx,
  TextEditingController passwordController,
) {
  passwordController.clear();
  showDialog(
    context: ctx,
    barrierDismissible: false,
    builder: (dialogCtx) => AlertDialog(
      backgroundColor: AppColors.latteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        LocaleKeys.delete_account_title.tr(),
        style: TextStyles.font16.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.redColor,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.delete_account_warning.tr(),
            style: TextStyles.font14.copyWith(
              color: AppColors.darkGrayColor,
              height: 1.5,
            ),
          ),
          const Gap(16),
          Text(
            LocaleKeys.delete_account_confirm_label.tr(),
            style: TextStyles.font14.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.darkColor,
            ),
          ),
          const Gap(8),
          AppTextField(
            controller: passwordController,
            hintText: LocaleKeys.current_password.tr(),
            isPass: true,
            keyboardType: TextInputType.visiblePassword,
          ),
          const Gap(16),
          SizedBox(
            width: MediaQuery.of(dialogCtx).size.width * 0.6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MainButton(
                  text: LocaleKeys.delete_account.tr(),
                  width: MediaQuery.of(dialogCtx).size.width * 0.3,
                  color: AppColors.redColor,
                  onPressed: () {
                    final password = passwordController.text.trim();
                    if (password.isEmpty) {
                      showMsgDialog(
                        dialogCtx,
                        LocaleKeys.please_enter_password.tr(),
                      );
                      return;
                    }
                    Navigator.of(dialogCtx).pop();
                    ctx.read<DeleteAccountCubit>().deleteAccount(
                      currentPassword: password,
                    );
                  },
                ),
                const Gap(10),
                MainButton(
                  text: LocaleKeys.cancel.tr(),
                  width: MediaQuery.of(dialogCtx).size.width * 0.25,
                  color: AppColors.primaryColor,
                  textColor: AppColors.whiteColor,
                  borderColor: AppColors.semiWhiteBorderColor,
                  onPressed: () => Navigator.of(dialogCtx).pop(),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
