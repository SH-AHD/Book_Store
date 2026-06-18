sealed class AddToCartStates {}


class AddToCartInitState extends AddToCartStates{}

class AddToCartLoadingState extends AddToCartStates{}


class AddToCartSuccessState extends AddToCartStates{
    final String msg;
  AddToCartSuccessState(this.msg);
}


class AddToCartErrorState extends AddToCartStates{
  final String errorMsg;
  AddToCartErrorState(this.errorMsg);
}
