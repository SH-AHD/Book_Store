import 'dart:developer';

import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/helpers/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_error_views.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/shimmer/shimmer_list_view.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:bookia/features/cart/data/models/cart_response_model/cart_item.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_states.dart';
import 'package:bookia/features/cart/presentation/widgets/cart_item_card.dart';
import 'package:bookia/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.my_cart.tr()),
        centerTitle: true,
        leading: SizedBox.shrink(),
      ),
      body: BlocBuilder<CartCubit, CartStates>(
        builder: (context, state) {
          var cubit = context.read<CartCubit>();
          if (state is CartLoadingState) {
            return ShimmerListView(
              itemCount: 3,
              itemHeight: 120,
              padding: EdgeInsets.all(20),
            );
          } else if (state is CartErrorState) {
            log(state.errorMsg);
            return errorMsgView();
          }

          if (cubit.cartItems.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPic(
                    path: AppAssets.cartSvg,
                    color: AppColors.grayColor,
                    w: 150,
                  ),
                  Gap(20),
                  Text(LocaleKeys.cart_empty.tr(), style: TextStyles.font20),
                ],
              ),
            );
          }
          return ListView.separated(
            padding: EdgeInsets.all(10),
            itemBuilder: (context, index) {
              CartItem citem = cubit.cartItems[index];
              return CartItemCard(
                cartItem: citem,
                onRemove: () {
                  cubit.deleteFromCart(citem.itemId ?? 0);
                },
                onIncrement: () {
                  if ((citem.itemQuantity ?? 0) <
                      (citem.itemProductStock ?? 0)) {
                    cubit.updateCart(
                      citem.itemId ?? 0,
                      citem.itemQuantity! + 1,
                    );
                  } else {
                    showMsgDialog(context, LocaleKeys.cant_add_more_stock.tr());
                  }
                },
                onDecrement: () {
                  if ((citem.itemQuantity ?? 0) > 1) {
                    cubit.updateCart(
                      citem.itemId ?? 0,
                      citem.itemQuantity! - 1,
                    );
                  } else {
                    cubit.deleteFromCart(citem.itemId ?? 0);
                  }
                },
              );
            },
            separatorBuilder: (context, index) => const Gap(8),
            itemCount: cubit.cartItems.length,
          );
        },
      ),

      bottomNavigationBar: BlocConsumer<CartCubit, CartStates>(
        listener: (context, state) {
          if (state is CheckoutLoadingState) {
            showLoadingDialog(context);
          } else if (state is CartErrorState) {
            popPage(context);
            showMsgDialog(context, state.errorMsg);
          } else if (state is CheckoutSuccessState) {
            popPage(context);
            pushPage(
              context,
              Routes.placeOrder,
              extra: context.read<CartCubit>().formattedTotal,
            );
          }
        },
        builder: (context, state) {
          var cubit = context.read<CartCubit>();
          if (cubit.cartItems.isEmpty) {
            return SizedBox.shrink();
          }
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LocaleKeys.total.tr(),
                      style: TextStyles.font20.copyWith(
                        color: AppColors.darkGrayColor,
                      ),
                    ),
                    Text(cubit.formattedTotal, style: TextStyles.font20),
                  ],
                ),
                Gap(12),
                MainButton(
                  text: LocaleKeys.check_out.tr(),
                  color: AppColors.darkColor,
                  onPressed: () => cubit.checkout(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
