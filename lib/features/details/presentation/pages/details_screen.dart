import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/helpers/navigation.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/body_view.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/custom_cached_network_image.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:bookia/features/home/data/models/all_products_response/product.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:readmore/readmore.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.book});
  final Product book;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () {
            popPage(context);
          },
          child: SvgPic(path: AppAssets.backSvg),
        ),
        actions: [
          Padding(
            padding: EdgeInsetsGeometry.only(right: 20),
            child: GestureDetector(
              onTap: () {},
              child: SvgPic(path: AppAssets.bookmarkSvg),
            ),
          ),
        ],
      ),
      body: _detailsBody(context),
      bottomNavigationBar: BodyView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "₹${book.price ?? ""}",
              style: TextStyles.font24,
              textAlign: TextAlign.center,
            ),

            MainButton(
              width: MediaQuery.sizeOf(context).width * 0.5,
              height: MediaQuery.sizeOf(context).height * 0.045,
              text: "Add To Cart",
              onPressed: () {},
              color: AppColors.darkColor,
            ),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView _detailsBody(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: BodyView(
          child: Column(
            children: [
              Hero(
                tag: book.id ?? "",
                child: CustomCachedNetworkImage(
                  url: book.image ?? "",
                  width: MediaQuery.sizeOf(context).width * 0.5,
                  height: MediaQuery.sizeOf(context).height * 0.4,
                ),
              ),
              Gap(20),
              Text(
                book.name ?? "",
                style: TextStyles.font30,
                textAlign: TextAlign.center,
              ),
              Gap(10),
              Text(
                book.category ?? "",
                style: TextStyles.font15.copyWith(
                  color: AppColors.primaryColor,
                ),
                textAlign: TextAlign.center,
              ),

              Gap(20),
              ReadMoreText(
                book.description ?? "",
                style: TextStyles.font14,
                textAlign: TextAlign.justify,
                trimMode: TrimMode.Line,
                trimLines: 4,
                colorClickableText: AppColors.primaryColor,
                trimCollapsedText: 'Show more',
                trimExpandedText: 'Show less',
                moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
