import 'package:bookia/core/services/apis/api_error_handler.dart';
import 'package:bookia/core/services/apis/dio.dart';
import 'package:bookia/core/services/apis/endpoints.dart';
import 'package:bookia/features/place_order/data/models/governrate_model/governrate_model.dart';
import 'package:bookia/features/place_order/data/models/place_order_model/place_order_params.dart';
import 'package:dio/dio.dart';

class PlaceOrderRepo {
  static Future<GovernrateModel?> getGovernrates() async {
    try {
      var response = await DioProvider.get(endpoint: EndPoints.governorates);
      if (response.statusCode == 200) {
        return GovernrateModel.fromJson(response.data);
      } else {
        return null;
      }
    } on DioException catch (e) {
      dioErrorHandler(e);
      return null;
    }
  }

  static Future<bool?> placeOrder(PlaceOrderParams params) async {
    try {
      var response = await DioProvider.post(
        endpoint: EndPoints.placeOrder,
        data: params.toJson(),
      );
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      dioErrorHandler(e);
    }
    return null;
  }
}
