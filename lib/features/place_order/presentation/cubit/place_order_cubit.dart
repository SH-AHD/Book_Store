import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/place_order/data/models/governrate_model/governorate_data.dart';
import 'package:bookia/features/place_order/data/models/place_order_model/place_order_params.dart';
import 'package:bookia/features/place_order/data/repository/place_order_repo.dart';
import 'package:bookia/features/place_order/presentation/cubit/place_order_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaceOrderCubit extends Cubit<PlaceOrderStates> {
  PlaceOrderCubit() : super(PlaceOrderInitStates());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();
  final governrateController = TextEditingController();

  List<GovernorateData> governrates = [];
  GovernorateData? selectedGov;

  Future<void> getGovernrates() async {
    emit(PlaceOrderLoadingState());
    try {
      var data = await PlaceOrderRepo.getGovernrates();
      if (data != null) {
        governrates = data.data ?? [];
        emit(GovernrateSuccessState(data.message ?? ""));
      }
    } on Exception catch (e) {
      emit(GovernrateErrorState(e.toString()));
    }
  }

  Future<void> placeOrder() async {
    if (selectedGov == null) {
      emit(PlaceOrderErrorState("Please select a governorate"));
      return;
    }
    emit(PlaceOrderLoadingState());
    try {
      var params = PlaceOrderParams(
        governorateId: selectedGov!.id!,
        name: fullNameController.text,
        phone: phoneNumberController.text,
        address: addressController.text,
        email: SharedPref.getUsrInfo()?.email ?? '',
      );

      var data = await PlaceOrderRepo.placeOrder(params);
      if (data == true) {
        emit(PlaceOrderSuccessState(""));
      } else {
        emit(PlaceOrderErrorState("Something went wrong"));
      }
    } on Exception catch (e) {
      emit(PlaceOrderErrorState(e.toString()));
    }
  }
}
