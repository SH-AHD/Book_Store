import 'package:bookia/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
   MainButton({super.key, required this.text,
   this.width=double.infinity, this.height=55, 
   this.color=AppColors.primaryColor, this.borderColor,
  required this.onPressed, this.textColor=AppColors.backgroundColor});
final String text;
final double width;
final double height;
final Color color;
final Color? borderColor;
 void Function()? onPressed;
 final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width, height),
        backgroundColor: color,
        side: borderColor!=null?BorderSide(color:borderColor! ):null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        )
      ),
      
      onPressed: onPressed
      , child: Text(text));
  }
}