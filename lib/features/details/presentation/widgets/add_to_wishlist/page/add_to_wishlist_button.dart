
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/helpers/navigation.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:bookia/features/details/presentation/widgets/add_to_wishlist/cubit/add_to_wishlist_cubit.dart';
import 'package:bookia/features/details/presentation/widgets/add_to_wishlist/cubit/add_to_wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';  

class AddToWishlistButton extends StatelessWidget {
  const AddToWishlistButton({super.key, required this.productId});
  final int productId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddToWishlistCubit(),
      child: BlocConsumer<AddToWishlistCubit, AddToWishlistState>(
        listener: (context, state) {
          if (state is AddToWishlistSuccessState) {
            popPage(context);
            showMsgDialog(context, state.msg, DialogType.success);
          } else if (state is AddToWishlistErrorEState) {
            popPage(context);
            showMsgDialog(context, state.errorMsg);
          } else if (state is AddToWishlistLoadingState) {
            showLoadingDialog(context);
          }
        },
        builder: (context, state) {
          var cubit = context.read<AddToWishlistCubit>();
          return IconButton(
            icon: SvgPic(
              path: AppAssets.bookmarkSvg,
              color: cubit.isProductInWishlist(productId)
                  ? AppColors.primaryColor
                  : null,
            ),
            onPressed: () {
              if (cubit.isProductInWishlist(productId)) {
                context.read<AddToWishlistCubit>().removeFromWishList(
                  productId,
                );
              } else {
                context.read<AddToWishlistCubit>().addToWishList(productId);
              }
            },
          );
        },
      ),
    );
  }
}