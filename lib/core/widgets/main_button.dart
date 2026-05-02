import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.text,
    this.width = double.infinity,
    this.height = 55,
    this.color = AppColors.primaryColor,
    this.borderColor,
    required this.onPressed,
    this.textColor = AppColors.whiteColor,
  });
  final String text;
  final double width;
  final double height;
  final Color color;
  final Color? borderColor;
  final VoidCallback? onPressed;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          side: borderColor != null ? BorderSide(color: borderColor!) : null,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      
        onPressed: onPressed,
        child: Text(text, style: TextStyles.font15.copyWith(color: textColor)),
      ),
    );
  }
}
