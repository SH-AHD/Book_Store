import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
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
          Text(message),
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