import 'package:bookia/core/constants/app_fonts.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:flutter/material.dart';

class AuthFooter extends StatelessWidget {
  const AuthFooter({
    super.key,
    required this.onTap,
    required this.ques,
    required this.actionsen,
  });
  final Function() onTap;
  final String ques;
  final String actionsen;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: ques,
              style: TextStyles.font14.copyWith(
                color: AppColors.blackfontColor,
                fontFamily: AppFonts.dMSerifDisplay,
              ),
            ),
            TextSpan(
              text: actionsen,
              style: TextStyles.font14.copyWith(
                color: AppColors.primaryColor,
                fontFamily: AppFonts.dMSerifDisplay,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
