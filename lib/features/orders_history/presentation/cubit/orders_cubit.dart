import 'package:bookia/features/orders_history/data/repo/orders_repo.dart';
import 'package:bookia/features/orders_history/presentation/cubit/orders_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitState());

  Future<void> showOrdersHistory() async {
    emit(OrdersLoadingState());
    try {
      var data = await OrdersRepo.showOrdersHistory();
      if(data!=null){
        emit(OrdersSuccessState(ordersModel: data,message: data.message??""));
      }else{
        emit(OrdersErrorState("Something went wrong"));
      }
    } catch (e) {
  emit(OrdersErrorState(e.toString()));
    }
  }

    Future<void> showSingleOrderHistory(int orderId) async {
    emit(OrdersLoadingState());
    try {
      var data = await OrdersRepo.showSingleOrderHistory(orderId: orderId);
      if(data!=null){
        emit(SingleOrderSuccessState(orderDetails: data.data!,msg:data.message));
      }else{
        emit(OrdersErrorState("Something went wrong"));
      }
    } catch (e) {
  emit(OrdersErrorState(e.toString()));
    }
  }
}
