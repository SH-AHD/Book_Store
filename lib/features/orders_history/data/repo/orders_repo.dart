import 'package:bookia/core/services/apis/api_error_handler.dart';
import 'package:bookia/core/services/apis/dio.dart';
import 'package:bookia/core/services/apis/endpoints.dart';
import 'package:bookia/features/orders_history/data/models/orders_model/orders_model.dart';
import 'package:bookia/features/orders_history/data/models/single_order_details_model/single_order_details_model.dart';
import 'package:dio/dio.dart';

class OrdersRepo {
  static Future<OrdersModel?> showOrdersHistory() async {
    try {
      var response = await DioProvider.get(endpoint: EndPoints.orderHistory);

      if (response.statusCode==200) {
        return OrdersModel.fromJson(response.data);
      } else {
        return null;
      }
    } on DioException catch (e) {
      dioErrorHandler(e);
    }
    return null;
  }

   static Future<SingleOrderDetailsModel?> showSingleOrderHistory({required int orderId}) async {
    try {
      var response = await DioProvider.get(
      endpoint: '${EndPoints.orderHistory}/$orderId',
      );

      if (response.statusCode==200) {
        return SingleOrderDetailsModel.fromJson(response.data);
      } else {
        return null;
      }
    } on DioException catch (e) {
      dioErrorHandler(e);
    }
    return null;
  }
}
