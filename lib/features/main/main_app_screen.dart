import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int index = 0;
  List<Widget> screens = [
    BlocProvider(
      create: (context) => HomeCubit()..getInitData(),
      child: HomeScreen(),
    ),
    Center(child: Text("wishlist")),
    Center(child: Text("cart")),
    Center(child: Text("profile")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) => setState(() {
          index = value;
        }),
        items: [
          BottomNavigationBarItem(
            icon: SvgPic(path: AppAssets.homeSvg),
            activeIcon: SvgPic(
              path: AppAssets.homeSvg,
              color: AppColors.primaryColor,
            ),
            label: "home",
          ),
          BottomNavigationBarItem(
            icon: SvgPic(path: AppAssets.bookmarkSvg),
            activeIcon: SvgPic(
              path: AppAssets.bookmarkSvg,
              color: AppColors.primaryColor,
            ),
            label: "wishlist",
          ),
          BottomNavigationBarItem(
            icon: SvgPic(path: AppAssets.cartSvg),
            activeIcon: SvgPic(
              path: AppAssets.cartSvg,
              color: AppColors.primaryColor,
            ),
            label: "cart",
          ),
          BottomNavigationBarItem(
            icon: SvgPic(path: AppAssets.profileSvg),
            activeIcon: SvgPic(
              path: AppAssets.profileSvg,
              color: AppColors.primaryColor,
            ),
            label: "profile",
          ),
        ],
      ),
    );
  }
}
