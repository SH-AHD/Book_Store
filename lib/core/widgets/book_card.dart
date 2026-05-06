import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/helpers/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/custom_cached_network_image.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:bookia/features/home/data/models/all_products_response/product.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BookCard extends StatelessWidget {
  const BookCard({super.key, required this.book,  this.onRemove, this.onRefresh});
  final Product book;
  final VoidCallback? onRemove;
  final VoidCallback? onRefresh;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushPage(context, Routes.details, extra: book).then((value) {
          onRefresh?.call();
        });
      },
      child: Container(
        padding: EdgeInsets.all(11),
        // height: 300,
        // width: 165,
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.3,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
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
                Text("₹${book.price ?? ""}", style: TextStyles.font18),
                
                onRemove!=null?
                GestureDetector(
                  onTap: onRemove,
                  child: SvgPic(path:  AppAssets.cancleSvg))
                : MainButton(
                  width: MediaQuery.sizeOf(context).width * 0.2,
                  height: MediaQuery.sizeOf(context).height * 0.048,
                  text: "Buy",
                  onPressed: () {},
                  color: AppColors.darkColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
