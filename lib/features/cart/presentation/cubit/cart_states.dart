
sealed class CartStates {}

class CartInitState extends CartStates{}

class CartLoadingState extends CartStates{}

class CartSuccessState extends CartStates{
  final String msg;
CartSuccessState(this.msg);
}
class CartLocalUpdateState extends CartStates{
//   final String msg;
// CartLocalUpdateState(this.msg);
}
class CartErrorState extends CartStates{
final String errorMsg;
CartErrorState(this.errorMsg);

}

class CheckoutLoadingState extends CartStates{}

class CheckoutSuccessState extends CartStates{
  final String msg;
CheckoutSuccessState(this.msg);
}


