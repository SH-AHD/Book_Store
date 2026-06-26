import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:flutter/material.dart';

class ProfileSettingsItem extends StatelessWidget {
  const ProfileSettingsItem({
    super.key,
    required this.title,
    required this.onTap,
  });
  final String title;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.semiWhiteBorderColor, width: 1),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyles.font18.copyWith(color: AppColors.black3Color),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 24),
        onTap: onTap,
      ),
    );
  }
}
