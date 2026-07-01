import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/helpers/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/body_view.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:bookia/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPic(path: AppAssets.successMark),
            const Gap(20),
            Text(LocaleKeys.success.tr(), style: TextStyles.font30),
            const Gap(20),

            Text(
              LocaleKeys.order_success_subtitle.tr(),
              textAlign: TextAlign.center,
              style: TextStyles.font16.copyWith(color: AppColors.grayColor),
            ),
            const Gap(30),

            MainButton(
              text: LocaleKeys.back_to_home.tr(),
              onPressed: () {
                pushAndRemoveUntilPage(context, Routes.main, extra: 0);
              },
            ),
          ],
        ),
      ),
    );
  }
}
