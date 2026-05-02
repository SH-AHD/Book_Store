import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/home/data/models/all_products_response/product.dart';
import 'package:bookia/features/wishlist/data/repository/wishlist_repo.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wishlist_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistCubit extends Cubit<WishlistStates>{

WishlistCubit(): super(WishlistInitStates());

List<Product>wishlistProducts=[];

Future<void> getWishList()async{
emit(WishlistLoadingStates());
try {
  var response=await WishlistRepo.getWishList();
  
  if(response!=null&&response.data!=null){
    wishlistProducts=response.data?.data??[];
    List<String> wishlistIds = wishlistProducts.map((e) => (e.id ?? 0).toString()).toList();
    await SharedPref.saveWishlistIds(wishlistIds);
  emit(WishlistSuccessStates(response.message??""));
  }
} on Exception catch (e) {
  emit(WishlistErrorStates(e.toString()));
}

}


Future<void> removeFromWishList(int productId)async{
emit(WishlistLoadingStates());
try {
  var response=await WishlistRepo.removeFromWishList(productId);
  
  if(response!=null&&response.data!=null){
    wishlistProducts=response.data?.data??[];
    List<String> wishlistIds = wishlistProducts.map((e) => (e.id ?? 0).toString()).toList();
    await SharedPref.saveWishlistIds(wishlistIds);
  emit(WishlistSuccessStates(response.message??""));
  }else{
    emit(WishlistErrorStates(response?.message??"Error"));
  }
} on Exception catch (e) {
  
  emit(WishlistErrorStates(e.toString()));
}

}

}