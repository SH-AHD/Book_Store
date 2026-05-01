import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/helpers/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppAssets.bg,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),

          Positioned(
            top: 0,
            left: 22,
            right: 22,
            bottom: 0,
            child: Column(
              children: [
                Spacer(flex: 2),
                SvgPic(path: AppAssets.logo),
                Gap(15),
                Text("Order Your Book Now!", style: TextStyles.font18),
                Spacer(flex: 5),
                MainButton(
                  text: "Login",
                  onPressed: () {
                    pushPage(context, Routes.login);
                  },
                ),
                Gap(15),
                MainButton(
                  text: "Register",
                  onPressed: () {
                    pushPage(context, Routes.register);
                  },
                  borderColor: AppColors.darkColor,
                  color: AppColors.whiteColor,
                  textColor: AppColors.darkColor,
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
