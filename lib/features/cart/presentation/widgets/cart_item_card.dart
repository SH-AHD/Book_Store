import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:bookia/features/cart/data/models/cart_response_model/cart_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
    required this.onRemove,
    required this.cartItem,
    required this.onIncrement,
    required this.onDecrement,
  });
  final CartItem cartItem;
  final VoidCallback onRemove;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.whiteColor,
      shadowColor: AppColors.latteColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppColors.semiWhiteBorderColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: cartItem.itemProductImage ?? "",
                width: 100,
                height: 110,
                fit: BoxFit.cover,
              ),
            ),
            Gap(20),
            Expanded(child: _bookInfoCol()),
            Gap(10),
            GestureDetector(
              onTap: onRemove,
              child: SvgPic(path: AppAssets.cancleSvg),
            ),
          ],
        ),
      ),
    );
  }

  Column _bookInfoCol() {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          cartItem.itemProductName ?? "",
          style: TextStyles.font18,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          "₹${cartItem.itemProductPriceAfterDiscount ?? cartItem.itemProductPrice}",
          style: TextStyles.font16,
        ),
        Row(
          spacing: 10,
          children: [
            _qCounter(
              icon: Icons.remove,
              onTap: cartItem.itemQuantity! > 1 ? onDecrement : null,
            ),
            SizedBox(
              width: 30,
              child: Text(
                "${cartItem.itemQuantity}",
                style: TextStyles.font18,
                textAlign: TextAlign.center,
              ),
            ),
            _qCounter(icon: Icons.add, onTap: onIncrement),
          ],
        ),
      ],
    );
  }

  GestureDetector _qCounter({IconData? icon, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: AppColors.lightGrayColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.darkColor),
      ),
    );
  }
}
