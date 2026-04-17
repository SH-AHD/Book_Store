import 'package:bookia/core/services/apis/dio.dart';
import 'package:bookia/core/services/apis/endpoints.dart';

class SearchRepo {

Future<void> search(String name)async{
var response =await DioProvider.get(endpoint: EndPoints.productsSearch);
// if(response.statusCode==200){
//   return
// }


}



}