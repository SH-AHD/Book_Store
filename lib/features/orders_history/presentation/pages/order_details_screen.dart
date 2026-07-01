import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/helpers/navigation.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/app_back_btn.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:bookia/features/orders_history/data/models/single_order_details_model/data.dart';
import 'package:bookia/features/orders_history/data/models/single_order_details_model/order_product.dart';
import 'package:bookia/features/orders_history/presentation/cubit/orders_cubit.dart';
import 'package:bookia/features/orders_history/presentation/cubit/orders_state.dart';
import 'package:bookia/features/orders_history/presentation/widgets/order_status_chip.dart';
import 'package:bookia/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        if (state is OrdersLoadingState) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(LocaleKeys.Order_details.tr()),
              leading:Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppBackBtn(),
            ),
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is OrdersErrorState) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(LocaleKeys.Order_details.tr()),
              leading:Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppBackBtn(),
            ),
            ),
            body: Center(
              child: Text(state.errMsg ?? '', style: TextStyles.font14),
            ),
          );
        }

        if (state is SingleOrderSuccessState) {
          final order = state.orderDetails;
          return _OrderDetailsContent(order: order);
        }

        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}

class _OrderDetailsContent extends StatelessWidget {
  final Data order;

  const _OrderDetailsContent({required this.order});

  @override
  Widget build(BuildContext context) {
    final products = order.orderProducts ?? [];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(LocaleKeys.order_number.tr(namedArgs: {'code': order.orderCode ?? ''})),
        leading:Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppBackBtn(),
            ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderHeader(order.status ?? '', order.orderDate ?? ''),
            const Gap(20),

            _buildSectionTitle(LocaleKeys.shipping_information.tr()),
            const Gap(8),
            _buildShippingInfoCard(order),
            const Gap(20),

            _buildSectionTitle(LocaleKeys.ordered_products.tr(namedArgs: {'count': products.length.toString()})),
            const Gap(8),
            _buildProductsList(products),
            const Gap(20),

            _buildSectionTitle(LocaleKeys.price_details.tr()),
            const Gap(8),
            _buildPriceSummaryCard(order),
            const Gap(24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyles.font16.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.primaryColor,
      ),
    );
  }

  Widget _buildOrderHeader(String status, String date) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(LocaleKeys.order_date.tr(), style: TextStyles.font14),
            Text(
              date,
              style: TextStyles.font14.copyWith(color: AppColors.grayColor),
            ),
          ],
        ),
        buildStatusChip(status),
      ],
    );
  }

  Widget _buildShippingInfoCard(Data order) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.grayColor.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            order.name ?? '',
            style: TextStyles.font16.copyWith(fontWeight: FontWeight.w600),
          ),
          const Gap(6),
          _buildInfoRow(Icons.phone, order.phone ?? ''),
          const Gap(4),
          _buildInfoRow(Icons.email, order.email ?? ''),
          const Gap(4),
          _buildInfoRow(
            Icons.location_on,
            "${order.address ?? ''}, ${order.governorate ?? ''}",
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.grayColor),
        const Gap(8),
        Expanded(
          child: Text(
            text,
            style: TextStyles.font14.copyWith(color: AppColors.grayColor),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildProductsList(List<OrderProduct> products) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          color: AppColors.whiteColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            title: Text(
              product.productName ?? '',
              style: TextStyles.font14.copyWith(fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 6),
              key: ValueKey(product.orderProductId),
              child: Text(
                "${LocaleKeys.qty.tr()}: ${product.orderProductQuantity}  ×  ${product.productPriceAfterDiscount ?? product.productPrice} ₹",
                style: TextStyles.font14.copyWith(color: AppColors.grayColor),
              ),
            ),
            trailing: Text(
              "${product.productTotal ?? '0'} ₹",
              style: TextStyles.font14.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPriceSummaryCard(Data order) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.grayColor.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          _buildPriceRow(LocaleKeys.subtotal.tr(), "${order.subTotal ?? '0'} ₹"),
          const Gap(8),
          _buildPriceRow(
            LocaleKeys.discount.tr(),
            "- ${order.discount ?? 0}%",
            isDiscount: true,
          ),
          const Gap(8),
          _buildPriceRow(LocaleKeys.tax.tr(), "${order.tax ?? '0'} ₹"),
          const Gap(12),
          const Divider(),
          const Gap(6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.total_amount.tr(),
                style: TextStyles.font16.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                "${order.total ?? '0'} ₹",
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

  Widget _buildPriceRow(String label, String value, {bool isDiscount = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyles.font14.copyWith(color: AppColors.grayColor),
        ),
        Text(
          value,
          style: TextStyles.font14.copyWith(
            color: isDiscount ? AppColors.darkGrayColor : Colors.black,
            fontWeight: isDiscount ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
