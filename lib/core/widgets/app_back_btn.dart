import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/extensions/localization_flags.dart';
import 'package:bookia/core/helpers/navigation.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:flutter/material.dart';

class AppBackBtn extends StatelessWidget {
  const AppBackBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        popPage(context);
      },
      child:context.isArabic ? RotatedBox(
        quarterTurns: 2,
        child: SvgPic(path: AppAssets.backSvg)) : SvgPic(path: AppAssets.backSvg),
    );
  }
}
