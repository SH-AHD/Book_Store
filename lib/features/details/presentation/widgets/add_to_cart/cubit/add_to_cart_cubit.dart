import 'package:bookia/features/cart/data/repo/cart_repo.dart';
import 'package:bookia/features/details/presentation/widgets/add_to_cart/cubit/add_to_cart_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToCartCubit extends Cubit<AddToCartStates> {
  AddToCartCubit() : super(AddToCartInitState());
  bool isAddedToCart = false;
  Future<void> addToCart(int cartItemId) async {
    emit(AddToCartLoadingState());

    try {
      var response = await CartRepo.addToCart(cartItemId);

      if (response?.data != null) {
        isAddedToCart = true;
        emit(AddToCartSuccessState(response!.message.toString()));
      }
    } catch (e) {
      emit(AddToCartErrorState(e.toString()));
    }
  }
}
