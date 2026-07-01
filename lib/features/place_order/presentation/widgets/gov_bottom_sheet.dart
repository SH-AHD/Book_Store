import 'package:bookia/core/helpers/navigation.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/features/place_order/data/models/governrate_model/governorate_data.dart';
import 'package:bookia/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

void showGovernrateBottomSheet(
  BuildContext context,
  List<GovernorateData> govs,
  Function(GovernorateData gov) onTap,
) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: AppColors.latteColor,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              LocaleKeys.select_governorate.tr(),
              style: TextStyles.font24.copyWith(color: AppColors.darkGrayColor),
            ),
            const Gap(15),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      govs[index].governorateNameEn ?? "",
                      style: TextStyles.font18.copyWith(
                        color: AppColors.darkGrayColor,
                      ),
                    ),
                    onTap: () {
                      popPage(context);
                      onTap(govs[index]);
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: govs.length,
              ),
            ),
          ],
        ),
      );
    },
  );
}
