import 'package:bookia/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';


Center errorMsgView(){
  return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, color: AppColors.redColor, size: 30),
                Gap(20),
                Text("Something went wrong..."),
              ],
            ),
          );
}