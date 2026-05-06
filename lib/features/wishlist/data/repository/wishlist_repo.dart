import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/services/apis/api_error_handler.dart';
import 'package:bookia/core/services/apis/dio.dart';
import 'package:bookia/core/services/apis/endpoints.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/wishlist/data/models/wishlist_response/wishlist_response.dart';
import 'package:dio/dio.dart';

class WishlistRepo {

static String token=SharedPref.getToken();

static Future<WishlistResponse?> getWishList() async{

try{
  var response=await DioProvider.get(
    endpoint: EndPoints.wishlist,
    headers:{'Authorization':'Bearer $token'}
    );

  if(response.statusCode==200){
return WishlistResponse.fromJson(response.data);
  }else{
    print("ERRROOOOORRR");
    return null;
  }
  }on DioException catch(error){
dioErrorHandler(error);
  }
return null;
}

static Future<WishlistResponse?> removeFromWishList(int productId) async{

try{
  var response=await DioProvider.post(
    endpoint: EndPoints.removeFromWishlist,
    data:{"product_id":productId},
    headers:{'Authorization':'Bearer $token'}
    );

  if(response.statusCode==200){
return WishlistResponse.fromJson(response.data);
  }else{
    print("ERRROOOOORRR");
    return null;
  }
  }on DioException catch(error){
dioErrorHandler(error);
  }
return null;
}


static Future<WishlistResponse?> addToWishList(int productId) async{

try{
  var response=await DioProvider.post(
    endpoint: EndPoints.addToWishlist,
    data:{"product_id":productId},
    headers:{'Authorization':'Bearer $token'}
    );

  if(response.statusCode==200){
return WishlistResponse.fromJson(response.data);
  }else{
    print("ERRROOOOORRR");
    return null;
  }
  }on DioException catch(error){
dioErrorHandler(error);
  }
return null;
}






}