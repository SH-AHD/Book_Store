import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/helpers/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_cached_network_image.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:bookia/features/details/presentation/widgets/add_to_cart/page/add_to_cart_button.dart';
import 'package:bookia/features/home/data/models/all_products_response/product.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    super.key,
    required this.book,
    this.onRemove,
    this.onRefresh,
    this.h,
    this.w,
    this.btnMinWidth,
    this.btnMaxWidth,
  });
  final Product book;
  final VoidCallback? onRemove;
  final VoidCallback? onRefresh;
  final double? h;
  final double? w;
  final double? btnMinWidth;
  final double? btnMaxWidth;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushPage(context, Routes.details, extra: book).then((value) {
          onRefresh?.call();
        });
      },
      child: Container(
        padding: EdgeInsets.all(10),
        // height: 300,
        // width: 165,
        height: h ?? MediaQuery.of(context).size.height * 0.2,
        width: w ?? MediaQuery.of(context).size.width * 0.3,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.latteColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Hero(
                tag: book.id ?? "",
                child: CustomCachedNetworkImage(url: book.image ?? ""),
              ),
            ),
            const Gap(5),
            Text(
              book.name ?? "",
              style: TextStyles.font18,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Gap(23),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("₹${book.priceAfterdiscount ??book.price}", style: TextStyles.font18),
                const Gap(10),
                onRemove != null
                    ? GestureDetector(
                        onTap: onRemove,
                        child: SvgPic(path: AppAssets.cancleSvg),
                      )
                    : Flexible(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: btnMinWidth??80,
                            maxWidth: btnMaxWidth??120,
                          ),
                        child:  AddToCartButton(book,cartItemId: book.id!,text: "Buy",),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
