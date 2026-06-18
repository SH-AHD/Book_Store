
import 'package:bookia/core/helpers/navigation.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/features/details/presentation/widgets/add_to_cart/cubit/add_to_cart_cubit.dart';
import 'package:bookia/features/details/presentation/widgets/add_to_cart/cubit/add_to_cart_states.dart';
import 'package:bookia/features/home/data/models/all_products_response/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton(Product book, {super.key, required this.cartItemId,this.text });
  final int cartItemId;
  final String ?text;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddToCartCubit(),
      child: BlocConsumer<AddToCartCubit, AddToCartStates>(
        listener: (context, state) {
          if (state is AddToCartLoadingState) {
            showLoadingDialog(context);
          } else if (state is AddToCartErrorState) {
            popPage(context);
            showMsgDialog(context, state.errorMsg);
          } else if (state is AddToCartSuccessState) {
            popPage(context);
          }
        },
        builder: (context, state) {
          var cubit = context.read<AddToCartCubit>();

          return cubit.isAddedToCart
              ? MainButton(
                  width: MediaQuery.sizeOf(context).width * 0.5,
                  height: MediaQuery.sizeOf(context).height * 0.045,
                  text: "Added To Cart!",
                  onPressed: () {},
                )
              : MainButton(
                  width: MediaQuery.sizeOf(context).width * 0.5,
                  height: MediaQuery.sizeOf(context).height * 0.045,
                  text: text??"Add To Cart",
                  onPressed: () {
                    cubit.addToCart(cartItemId);
                  },
                  color: AppColors.darkColor,
                );
        },
      ),
    );
  }
}
