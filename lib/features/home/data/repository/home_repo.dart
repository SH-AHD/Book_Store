import 'package:bookia/core/services/apis/api_error_handler.dart';
import 'package:bookia/core/services/apis/dio.dart';
import 'package:bookia/core/services/apis/endpoints.dart';
import 'package:bookia/features/home/data/models/silder_response/silder_response.dart';
import 'package:dio/dio.dart';

import '../models/best_seller_response/best_seller_response.dart';

class HomeRepo {
  static Future<SilderResponse?> getSlider() async {
    try {
      var response = await DioProvider.get(endpoint: EndPoints.sliders);
      return SilderResponse.fromJson(response.data);
    } on DioException catch (error) {
      dioErrorHandler(error);
    }
    return null;
  }

  static Future<BestSellerResponse?> getBestSeller() async {
    try {
      var response = await DioProvider.get(endpoint: EndPoints.bestSeller);
      return BestSellerResponse.fromJson(response.data);
    } on DioException catch (error) {
     dioErrorHandler(error);
    }
    return null;
  }
}
