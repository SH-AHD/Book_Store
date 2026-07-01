import 'package:bookia/core/helpers/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/features/profile/presentation/cubit/delete_account_cubit.dart';
import 'package:bookia/features/profile/presentation/cubit/delete_account_state.dart';
import 'package:bookia/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteAccountButton extends StatelessWidget {
  final void Function(BuildContext ctx) onTap;

  const DeleteAccountButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteAccountCubit, DeleteAccountState>(
      listener: (context, state) {
        if (state is DeleteAccountLoadingState) {
          showLoadingDialog(context);
        } else if (state is DeleteAccountErrorState) {
          popPage(context);
          showMsgDialog(context, state.errorMsg);
        } else if (state is DeleteAccountSuccessState) {
          popPage(context);
          SharedPref.prefs.clear();
          pushAndRemoveUntilPage(context, Routes.welcome);
        }
      },
      child: GestureDetector(
        onTap: () => onTap(context),
        child: Container(
          width: 120,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.redColor.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: AppColors.redColor.withValues(alpha: 0.3),
            ),
          ),
          child: Center(
            child: Text(
              LocaleKeys.delete_account.tr(),
              style: TextStyles.font14.copyWith(
                color: AppColors.redColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
