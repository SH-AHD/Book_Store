import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/helpers/navigation.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:flutter/material.dart';

class PlaceOrderScreen extends StatelessWidget {
  const PlaceOrderScreen({super.key, required this.total});
  final String total;
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
      ),
      body: Column(
        children: [Text("Place Your Order", style: TextStyles.font30)],
      ),
    );
  }
}
