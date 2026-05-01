import 'package:bookia/core/services/apis/api_error_handler.dart';
import 'package:bookia/core/services/apis/dio.dart';
import 'package:bookia/core/services/apis/endpoints.dart';
import 'package:bookia/features/search/data/models/search_products_model/search_products_model.dart';
import 'package:dio/dio.dart';

class SearchRepo {


 Future<SearchProductsModel?> search({required String name})async{
try {
  var response =await DioProvider.get(
    endpoint: EndPoints.productsSearch,
    queryParameters: {"name":name}
    );
  if(response.statusCode==200){
   return SearchProductsModel.fromJson(response.data);
  }else{
  return null;
  }
} on DioException catch (e) {
  dioErrorHandler(e);
}
return null;
}



}