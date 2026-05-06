sealed class AddToWishlistState {}

class AddToWishlistInitState extends AddToWishlistState{}

class AddToWishlistLoadingState extends AddToWishlistState{}
class AddToWishlistSuccessState extends AddToWishlistState{

  final String msg;
AddToWishlistSuccessState(this.msg);
}
class AddToWishlistErrorEState extends AddToWishlistState{
final String errorMsg;
AddToWishlistErrorEState(this.errorMsg);

}




