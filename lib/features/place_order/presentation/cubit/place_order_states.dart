sealed class PlaceOrderStates {}

class PlaceOrderInitStates extends PlaceOrderStates {}

class PlaceOrderLoadingState extends PlaceOrderStates {}

class PlaceOrderSuccessState extends PlaceOrderStates {
  final String msg;
  PlaceOrderSuccessState(this.msg);
}

class PlaceOrderErrorState extends PlaceOrderStates {
  final String errMsg;
  PlaceOrderErrorState(this.errMsg);
}

class GovernrateSuccessState extends PlaceOrderStates {
  final String msg;
  GovernrateSuccessState(this.msg);
}

class GovernrateErrorState extends PlaceOrderStates {
  final String errMsg;
  GovernrateErrorState(this.errMsg);
}
