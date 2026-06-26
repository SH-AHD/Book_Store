import 'package:bookia/features/orders_history/data/models/orders_model/orders_model.dart';
import 'package:bookia/features/orders_history/data/models/single_order_details_model/data.dart';

sealed class OrdersState {}

class OrdersInitState extends OrdersState {}

class OrdersLoadingState extends OrdersState {}

class SingleOrderSuccessState extends OrdersState {
  Data orderDetails;
  String? msg;
  SingleOrderSuccessState({required this.orderDetails, required this.msg});
}

class OrdersErrorState extends OrdersState {
  String? errMsg;
  OrdersErrorState(this.errMsg);
}

class OrdersSuccessState extends OrdersState {
  final OrdersModel ordersModel;
  final String message;
  OrdersSuccessState({required this.ordersModel, required this.message});
}