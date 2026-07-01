import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/helpers/app_validator.dart';
import 'package:bookia/core/helpers/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/app_back_btn.dart';
import 'package:bookia/core/widgets/app_text_field.dart';
import 'package:bookia/core/widgets/body_view.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:bookia/features/place_order/presentation/cubit/place_order_cubit.dart';
import 'package:bookia/features/place_order/presentation/cubit/place_order_states.dart';
import 'package:bookia/features/place_order/presentation/widgets/gov_bottom_sheet.dart';
import 'package:bookia/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({super.key, required this.total});
  final String total;

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PlaceOrderCubit>().getGovernrates();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlaceOrderCubit, PlaceOrderStates>(
      listener: (context, state) {
        if (state is PlaceOrderLoadingState) {
          showLoadingDialog(context);
        } else if (state is PlaceOrderErrorState) {
          popPage(context);
          showMsgDialog(context, state.errMsg);
        } else if (state is PlaceOrderSuccessState) {
          popPage(context);
          pushReplacementPage(context, Routes.orderSuccess);
        } else if (state is GovernrateErrorState) {
          showMsgDialog(context, state.errMsg);
        } else if (state is GovernrateSuccessState) {
          // Governorates loaded successfully — dismiss loading dialog
          popPage(context);
        }
      },
      builder: (context, state) {
        var cubit = context.read<PlaceOrderCubit>();
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
              title: AppBackBtn(),
          ),
          body: SingleChildScrollView
          (child: _formBuilder(context)),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LocaleKeys.total.tr(),
                      style: TextStyles.font20.copyWith(
                        color: AppColors.darkGrayColor,
                      ),
                    ),
                    Text(widget.total, style: TextStyles.font20),
                  ],
                ),
                Gap(12),
                MainButton(
                  text: LocaleKeys.place_order_btn.tr(),
                  color: AppColors.darkColor,
                  onPressed: () {
                    if (cubit.formKey.currentState!.validate()) {
                      cubit.placeOrder();
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _formBuilder(BuildContext context) {
    return BlocBuilder<PlaceOrderCubit, PlaceOrderStates>(
      builder: (context, state) {
        var cubit = context.read<PlaceOrderCubit>();

        return BodyView(
          child: Form(
            key: cubit.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(LocaleKeys.place_your_order.tr(), style: TextStyles.font30),
                Gap(10),
                Text(
                  LocaleKeys.place_order_subtitle.tr(),
                  style: TextStyles.font16.copyWith(color: AppColors.grayColor),
                ),
                Gap(25),
                AppTextField(
                  controller: cubit.fullNameController,
                  hintText: LocaleKeys.full_name.tr(),
                  validator: AppValidators.validateUsername,
                ),
                Gap(12),
                AppTextField(
                  controller: cubit.phoneNumberController,
                  hintText: LocaleKeys.phone_number.tr(),
                  keyboardType: TextInputType.number,
                  maxLength: 11,
                  validator: AppValidators.validatePhoneNumber,
                ),
                Gap(12),
                AppTextField(
                  controller: cubit.addressController,
                  hintText: LocaleKeys.address.tr(),
                  keyboardType: TextInputType.streetAddress,
                  validator: AppValidators.validateString,
                ),
                Gap(12),
                AppTextField(
                  controller: cubit.governrateController,
                  hintText: LocaleKeys.governorate.tr(),
                  readOnly: true,
                  suffwid: Icon(Icons.keyboard_arrow_down),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return LocaleKeys.please_select_governorate.tr();
                    }
                    return null;
                  },
                  onTap: () => showGovernrateBottomSheet(
                    context,
                    context.read<PlaceOrderCubit>().governrates,
                    (gov) {
                      cubit.selectedGov = gov;
                      cubit.governrateController.text =
                          gov.governorateNameEn ?? "";
                    },
                  ),
                ),
                Gap(12),
              ],
            ),
          ),
        );
      },
    );
  }
}
