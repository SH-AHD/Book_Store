import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(height: 2, color: AppColors.borderColor)),
            Gap(47),
            Text(
              "Or",
              style: TextStyles.font14.copyWith(color: AppColors.darkGrayColor),
            ),
            Gap(47),
            Expanded(child: Divider(height: 2, color: AppColors.borderColor)),
          ],
        ),
        Gap(21),
        SocialButton(
          text: "Sign in with Google",
          path: AppAssets.googleSvg,
          onTap: () {},
        ),
        Gap(15),
        SocialButton(
          text: "Sign in with Apple",
          path: AppAssets.appleSvg,
          onTap: () {},
        ),
      ],
    );
  }
}

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.path,
    required this.text,
    required this.onTap,
  });
  final String path;
  final String text;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.backgroundColor,
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPic(path: path),
            Gap(4),
            Text(
              text,
              style: TextStyles.font14.copyWith(color: AppColors.darkGrayColor),
            ),
          ],
        ),
      ),
    );
  }
}
