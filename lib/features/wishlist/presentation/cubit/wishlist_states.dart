sealed class WishlistStates {}


class WishlistInitStates extends WishlistStates{}

class WishlistLoadingStates extends WishlistStates{}
class WishlistSuccessStates extends WishlistStates{
final String msg;
WishlistSuccessStates(this.msg);

}
class WishlistErrorStates extends WishlistStates{
  final String error;
  WishlistErrorStates(this.error);
}



