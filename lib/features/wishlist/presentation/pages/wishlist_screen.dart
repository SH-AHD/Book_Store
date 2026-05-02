import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/body_view.dart';
import 'package:bookia/core/widgets/book_card.dart';
import 'package:bookia/core/widgets/custom_error_views.dart';
import 'package:bookia/core/widgets/shimmer/shimmer_grid_view.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wishlist_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});
  @override
  Widget build(BuildContext context) {
    WishlistCubit cubit =context.read<WishlistCubit>();
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Wishlist')),
      body: BodyView(
        child: BlocBuilder<WishlistCubit, WishlistStates>(
          builder: (context, state) {
            var books = cubit.wishlistProducts;
            if (state is WishlistLoadingStates) {
              return ShimmerGridView(
                itemCount: 6,

                itemHeight: MediaQuery.of(context).size.height * 0.2,
                crossAxisCount: 2,
                childAspectRatio: .62,
              );
            } else if (state is WishlistSuccessStates) {
              if (books.isEmpty) {
                        return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPic(path: AppAssets.bookmarkSvg,color: AppColors.darkColor,w: 70,),
                  Gap(30),
                  Text(
                    "Start adding your favorite books!",
                    style: TextStyles.font15.copyWith(color: AppColors.darkColor),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
                      }

              return GridView.builder(
                itemCount: books.length,
              
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.55,
                ),
                itemBuilder: (context, index) => BookCard(
                  book: books[index],
                onRemove: () {
                  cubit.removeFromWishList(books[index].id!);
                },
                onRefresh: () {
                  context.read<WishlistCubit>().getWishList();
                },
                ),
              );
            } else if (state is WishlistErrorStates) {
              return errorMsgView();
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPic(path: AppAssets.bookmarkSvg,color: AppColors.darkColor,w: 70,),
                  Gap(30),
                  Text(
                    "Start adding your favorite books!",
                    style: TextStyles.font15.copyWith(color: AppColors.darkColor),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
