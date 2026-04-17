import 'package:bookia/core/constants/app_fonts.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData get lightTheme => ThemeData(
    fontFamily: AppFonts.dMSerifDisplay,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.backgroundColor,
      onSurface: AppColors.blackfontColor,
    ),

    appBarTheme: AppBarTheme(backgroundColor: AppColors.backgroundColor),

    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.borderColor),
      ),

      hintStyle: TextStyles.font15.copyWith(color: AppColors.grayColor),

      filled: true,
      fillColor: AppColors.lightGrayColor,
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
    ),
  );
}
