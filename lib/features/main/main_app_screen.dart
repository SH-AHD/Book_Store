import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/presentation/page/cart_screen.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/pages/home_screen.dart';
import 'package:bookia/features/profile/presentation/screen/profile_screen.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:bookia/features/wishlist/presentation/pages/wishlist_screen.dart';
import 'package:bookia/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key, this.currentIndex = 0});
  final int? currentIndex;

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  late int index;

  @override
  void initState() {
    super.initState();
    index = widget.currentIndex ?? 0;
  }

  @override
  void didUpdateWidget(covariant MainAppScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentIndex != oldWidget.currentIndex) {
      index = widget.currentIndex ?? 0;
    }
  }

  late final List<Widget> screens = [
    BlocProvider(
      create: (context) => HomeCubit()..getInitData(),
      child: HomeScreen(),
    ),
    BlocProvider(
      create: (context) => WishlistCubit()..getWishList(),
      child: WishlistScreen(),
    ),
    BlocProvider(
      create: (context) => CartCubit()..showCart(),
      child: CartScreen(),
    ),

    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.latteColor,
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
            label: LocaleKeys.home.tr(),
          ),
          BottomNavigationBarItem(
            icon: SvgPic(path: AppAssets.bookmarkSvg),
            activeIcon: SvgPic(
              path: AppAssets.bookmarkSvg,
              color: AppColors.primaryColor,
            ),
            label: LocaleKeys.wishlist.tr(),
          ),
          BottomNavigationBarItem(
            icon: SvgPic(path: AppAssets.cartSvg),
            activeIcon: SvgPic(
              path: AppAssets.cartSvg,
              color: AppColors.primaryColor,
            ),
            label: LocaleKeys.cart.tr(),
          ),
          BottomNavigationBarItem(
            icon: SvgPic(path: AppAssets.profileSvg),
            activeIcon: SvgPic(
              path: AppAssets.profileSvg,
              color: AppColors.primaryColor,
            ),
            label: LocaleKeys.profile.tr(),
          ),
        ],
      ),
    );
  }
}
