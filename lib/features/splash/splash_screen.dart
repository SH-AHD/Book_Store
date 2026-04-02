import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/helpers/navigation.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:bookia/features/welcome/welocme_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
@ override void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3),(){
PushReplacementPage(context,WelcomeScreen());
    });
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPic(path: AppAssets.logo,),
            Gap(15),
            Text("Order Your Book Now!", style: TextStyles.font18,),
          ],
        ),
      ),
    );
  }
}