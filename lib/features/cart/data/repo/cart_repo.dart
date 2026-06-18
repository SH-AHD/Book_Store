import 'package:bookia/core/services/apis/api_error_handler.dart';
import 'package:bookia/core/services/apis/dio.dart';
import 'package:bookia/core/services/apis/endpoints.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/cart/data/models/cart_response_model/cart_response_model.dart';
import 'package:dio/dio.dart';

class CartRepo {
  static Future<CartResponseModel?> getCart() async {
    String token = SharedPref.getToken();

    try {
      var response = await DioProvider.get(
        endpoint: EndPoints.cart,
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        return CartResponseModel.fromJson(response.data);
      } else {
        return null;
      }
    } on DioException catch (e) {
      dioErrorHandler(e);
    }

    return null;
  }

  static Future<CartResponseModel?> addToCart(int productId) async {
    String token = SharedPref.getToken();

    try {
      var response = await DioProvider.post(
        endpoint: EndPoints.addToCart,
        data: {"product_id": productId},
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 201) {
        return CartResponseModel.fromJson(response.data);
      } else {
        return null;
      }
    } on DioException catch (e) {
      dioErrorHandler(e);
    }

    return null;
  }

  static Future<CartResponseModel?> updateToCart(
    int cartItemId,
    int quantity,
  ) async {
    String token = SharedPref.getToken();

    try {
      var response = await DioProvider.post(
        endpoint: EndPoints.updateCart,
        data: {"cart_item_id": cartItemId, "quantity": quantity},
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 201) {
        return CartResponseModel.fromJson(response.data);
      } else {
        return null;
      }
    } on DioException catch (e) {
      dioErrorHandler(e);
    }

    return null;
  }

  static Future<CartResponseModel?> removeFromCart(int cartItemId) async {
    String token = SharedPref.getToken();

    try {
      var response = await DioProvider.post(
        endpoint: EndPoints.removeFromCart,
        data: {"cart_item_id": cartItemId},
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        return CartResponseModel.fromJson(response.data);
      } else {
        return null;
      }
    } on DioException catch (e) {
      dioErrorHandler(e);
    }

    return null;
  }

  static Future<CartResponseModel?> checkout() async {
    String token = SharedPref.getToken();

    try {
      var response = await DioProvider.get(
        endpoint: EndPoints.checkout,
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        return CartResponseModel.fromJson(response.data);
      } else {
        return null;
      }
    } on DioException catch (e) {
      dioErrorHandler(e);
    }

    return null;
  }
}
