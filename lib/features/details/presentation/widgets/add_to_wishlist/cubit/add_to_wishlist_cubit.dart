import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/details/presentation/widgets/add_to_wishlist/cubit/add_to_wishlist_state.dart';
import 'package:bookia/features/wishlist/data/repository/wishlist_repo.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AddToWishlistCubit extends Cubit<AddToWishlistState>{

AddToWishlistCubit():super(AddToWishlistInitState());

Future<void> addToWishList(int productId)async{
emit(AddToWishlistLoadingState());


try{

var response=await WishlistRepo.addToWishList(productId);
  
  if(response!=null&&response.data!=null){
    List<String> wishlistIds = SharedPref.getWishlistIds();
    if (!wishlistIds.contains(productId.toString())) {
      wishlistIds.add(productId.toString());
      await SharedPref.saveWishlistIds(wishlistIds);
    }
  emit(AddToWishlistSuccessState(response.message??""));
  }else{
    emit(AddToWishlistErrorEState(response?.message??"Error"));
  }
} on Exception catch (e) {
  
  emit(AddToWishlistErrorEState(e.toString()));
}

}



Future<void> removeFromWishList(int productId)async{
emit(AddToWishlistLoadingState());
try {
  var response=await WishlistRepo.removeFromWishList(productId);
  
  if(response!=null&&response.data!=null){
    List<String> wishlistIds = SharedPref.getWishlistIds();
    wishlistIds.remove(productId.toString());
    await SharedPref.saveWishlistIds(wishlistIds);
  emit(AddToWishlistSuccessState(response.message??""));
  }else{
    emit(AddToWishlistErrorEState(response?.message??"Error"));
  }
} on Exception catch (e) {
  
  emit(AddToWishlistErrorEState(e.toString()));
}

}


 bool isProductInWishlist(int productId) {
    return SharedPref.getWishlistIds().contains(productId.toString());
  }

}