import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/body_view.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:bookia/features/home/widgets/home_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
        
        title: SvgPic(path: AppAssets.logo, w: 100,),
        actions: [
          IconButton(onPressed: (){

          }, icon: SvgPic(path: AppAssets.searchSvg))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeSlider(),
            Gap(31),
            BodyView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text("Best Seller", style: TextStyles.font24),
                  Gap(15),
                  GridView.builder(
                    itemCount: 6,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 0.55,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(11),
                        height: 300,
                        width: 165,
                        decoration: BoxDecoration(
                          color: AppColors.cardBgColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  AppAssets.bg,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const Gap(5),
                            Text(
                              "The Republidfdfd dfgc",
                              style: TextStyles.font18,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Gap(23),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("₹285", style: TextStyles.font18),
                                MainButton(
                                  width: 60,
                                  height: 35,
                                  text: "Buy",
                                  onPressed: () {},
                                  color: AppColors.darkColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const Gap(30),
          ],
        ),
      ),
    );
  }
}
