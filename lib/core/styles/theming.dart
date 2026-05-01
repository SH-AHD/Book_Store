import 'package:bookia/core/constants/app_fonts.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppThemes {
  static ThemeData get lightTheme => ThemeData(
    fontFamily: AppFonts.dMSerifDisplay,
    scaffoldBackgroundColor: AppColors.latteColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.whiteColor,
      onSurface: AppColors.blackfontColor,
    ),

    appBarTheme: AppBarTheme(backgroundColor: AppColors.latteColor,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    surfaceTintColor: Colors.transparent,
    ),

    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.semiWhiteBorderColor),
      ),

focusedBorder:OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),

      hintStyle: TextStyles.font15.copyWith(color: AppColors.grayColor),

    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
    ),
  );
}
