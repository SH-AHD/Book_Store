import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/helpers/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 
  @override
  void initState() {
    super.initState();

 bool isLoggedIn=SharedPref.getToken().isNotEmpty;
    Future.delayed(const Duration(seconds: 3), () {
      // pushReplacementPage(context, Routes.main);

     if(isLoggedIn){
      pushReplacementPage(context, Routes.main);
     }
else{
      pushReplacementPage(context, Routes.welcome);

}
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPic(path: AppAssets.logo),
            Gap(15),
            Text("Order Your Book Now!", style: TextStyles.font18),
          ],
        ),
      ),
    );
  }
}
