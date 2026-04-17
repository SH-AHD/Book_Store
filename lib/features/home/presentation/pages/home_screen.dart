import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:bookia/features/home/presentation/widgets/best_seller_builder.dart';
import 'package:bookia/features/home/presentation/widgets/home_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        title: SvgPic(path: AppAssets.logo, w: 100),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPic(path: AppAssets.searchSvg),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gap(20),
            HomeSlider(),
            Gap(31),
            BestSellerBuilder(),

            const Gap(30),
          ],
        ),
      ),
    );
  }
}
