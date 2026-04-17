import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/helpers/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/body_view.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PasswordChangedScreen extends StatelessWidget {
  const PasswordChangedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPic(path: AppAssets.successMark),
              Text("Password Changed!", style: TextStyles.font30),
              Gap(3),
              Text(
                "Your password has been changed successfully.",
                style: TextStyles.font16.copyWith(color: AppColors.grayColor),
              ),
              Gap(40),
              MainButton(
                text: "Back to Login",
                onPressed: () {
                  pushAndRemoveUntilPage(context, Routes.login);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
