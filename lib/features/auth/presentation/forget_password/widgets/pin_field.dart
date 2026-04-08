import 'package:bookia/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class PinField extends StatelessWidget {
 const PinField({super.key, this.onComplete});
final void Function(String)? onComplete;


  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
  width: 48,
  height: 60,
  textStyle: TextStyle(fontSize: 20, color: AppColors.darkColor, fontWeight: FontWeight.w700),
  decoration: BoxDecoration(
    border: Border.all(color: AppColors.borderColor),
    borderRadius: BorderRadius.circular(8),
    color: AppColors.lightGrayColor
  ),
);

final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  border: Border.all(color: AppColors.primaryColor),
  borderRadius: BorderRadius.circular(8),
  color: AppColors.backgroundColor
);

final submittedPinTheme = defaultPinTheme.copyWith(
  decoration: defaultPinTheme.decoration!.copyWith(
      border: Border.all(color: AppColors.primaryColor),
  borderRadius: BorderRadius.circular(8),
  color: AppColors.backgroundColor
  ),
);


    
    return Pinput(
defaultPinTheme: defaultPinTheme,
focusedPinTheme: focusedPinTheme,
submittedPinTheme: submittedPinTheme,
length: 6,
validator: (s) {
return s == '555555' ? null : 'Pin is incorrect';
},
pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
showCursor: true,
onCompleted:onComplete
);
  }
}