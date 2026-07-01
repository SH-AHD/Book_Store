import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/helpers/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/app_back_btn.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:bookia/features/orders_history/data/models/orders_model/order.dart';
import 'package:bookia/features/orders_history/presentation/cubit/orders_cubit.dart';
import 'package:bookia/features/orders_history/presentation/cubit/orders_state.dart';
import 'package:bookia/features/orders_history/presentation/widgets/order_status_chip.dart';
import 'package:bookia/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(LocaleKeys.My_orders.tr()),
        leading:Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppBackBtn(),
            ),
      ),
      body: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          if (state is OrdersLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrdersErrorState) {
            return Center(
              child: Text(state.errMsg ?? "", style: TextStyles.font14),
            );
          } else if (state is OrdersSuccessState) {
            final ordersList = state.ordersModel.data?.orders ?? [];

            if (ordersList.isEmpty) {
              return Center(
                child: Text(LocaleKeys.no_orders_found.tr(), style: TextStyles.font16),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: ordersList.length,
              separatorBuilder: (context, index) => const Gap(14),
              itemBuilder: (context, index) {
                final order = ordersList[index];
                return GestureDetector(
                  onTap: () {
                    pushPage(context, Routes.orderDetails, extra: order.id);
                  },
                  child: _OrderCard(order: order),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _OrderCard({required Order order}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.grayColor.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.order_number.tr(namedArgs: {'code': order.orderCode ?? ''}),
                style: TextStyles.font16.copyWith(fontWeight: FontWeight.bold),
              ),
              buildStatusChip(order.status ?? ''),
            ],
          ),
          const Gap(10),
          Text(
            "${LocaleKeys.order_date.tr()}: ${order.orderDate ?? ''}",
            style: TextStyles.font14.copyWith(color: AppColors.grayColor),
          ),
          const Gap(12),
          const Divider(thickness: 0.8),
          const Gap(6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.total_amount.tr(),
                style: TextStyles.font14.copyWith(color: AppColors.grayColor),
              ),
              Text(
                "${order.total ?? '0.00'} ₹",
                style: TextStyles.font16.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
