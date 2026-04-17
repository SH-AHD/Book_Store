import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

void showErrorDialog(BuildContext context, String errorMsg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(5),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(10),
      ),
      backgroundColor: AppColors.redColor,
      content: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: AppColors.backgroundColor,
            weight: 10,
          ),
          Gap(10),
          Expanded(child: Text(errorMsg, style: TextStyles.font14)),
        ],
      ),
    ),
  );
}

void showLoadingDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,

    context: context,
    builder: (_) => const Center(child: CircularProgressIndicator()),
  );
}
