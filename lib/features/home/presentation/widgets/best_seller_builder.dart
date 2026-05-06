import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/body_view.dart';
import 'package:bookia/core/widgets/custom_error_views.dart';
import 'package:bookia/core/widgets/shimmer/shimmer_grid_view.dart';
import 'package:bookia/features/home/data/models/all_products_response/product.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/cubit/home_state.dart';
import 'package:bookia/core/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class BestSellerBuilder extends StatelessWidget {
  const BestSellerBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final List<Product> bestProducts = context
            .read<HomeCubit>()
            .bestSellerProducts;
        if (state is HomeLoadingState) {
          return BodyView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text("Best Seller", style: TextStyles.font24),
                Gap(15),
                ShimmerGridView(
                  itemCount: 6,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemHeight: MediaQuery.of(context).size.height * 0.2,
                  crossAxisCount: 2,
                  childAspectRatio: .62,
                ),
              ],
            ),
          );
        } else if (state is HomeErrorState) {
          errorMsgView();
        }
        return BodyView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text("Best Seller", style: TextStyles.font24),
              Gap(15),
              GridView.builder(
                itemCount: bestProducts.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.55,
                ),
                itemBuilder: (context, index) {
                  return BookCard(book: bestProducts[index]);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
