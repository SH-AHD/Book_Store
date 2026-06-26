import 'package:bookia/features/cart/data/models/cart_response_model/cart_item.dart';
import 'package:bookia/features/cart/data/repo/cart_repo.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(CartInitState());
  String total = "";
  String get formattedTotal =>
      (double.tryParse(total) ?? 0.0).toStringAsFixed(2);
  List<CartItem> cartItems = [];
  List<int> cartProductIds = [];

  void _updateCartProductIds() {
    cartProductIds = cartItems.map((e) => e.itemProductId ?? 0).toList();
  }

  Future<void> showCart() async {
    emit(CartLoadingState());

    try {
      var response = await CartRepo.getCart();

      if (response != null && response.data != null) {
        total = response.data!.total.toString();
        cartItems = response.data!.cartItems ?? [];
        _updateCartProductIds();
        if (isClosed) return;
        emit(CartSuccessState(response.message.toString()));
      } else {
        if (isClosed) return;
        emit(CartErrorState(response?.message ?? "Failed to load cart"));
      }
    } catch (e) {
      if (isClosed) return;
      emit(CartErrorState(e.toString()));
    }
  }

  Future<void> deleteFromCart(int cartItemId) async {
    emit(CartLoadingState());

    try {
      var response = await CartRepo.removeFromCart(cartItemId);

      if (response != null && response.data != null) {
        total = response.data!.total.toString();
        cartItems = response.data!.cartItems ?? [];
        _updateCartProductIds();
        if (isClosed) return;
        emit(CartSuccessState(response.message.toString()));
      } else {
        if (isClosed) return;
        emit(CartErrorState(response?.message ?? "Failed to remove item"));
      }
    } catch (e) {
      if (isClosed) return;
      emit(CartErrorState(e.toString()));
    }
  }

  Future<void> updateCart(int cartItemId, int quantity) async {
    CartItem targetItem = cartItems.firstWhere(
      (book) => book.itemId == cartItemId,
    );

    int oldQuantity = targetItem.itemQuantity ?? 1;
    double oldItemTotal = targetItem.itemTotal?.toDouble() ?? 0.0;
    String oldCartTotal = total;

    double price = targetItem.itemProductPriceAfterDiscount?.toDouble() ?? 0.0;
    double newItemTotal = price * quantity;

    double currentCartTotal = double.tryParse(total) ?? 0.0;
    currentCartTotal = (currentCartTotal - oldItemTotal) + newItemTotal;

    targetItem.itemQuantity = quantity;
    targetItem.itemTotal = newItemTotal;
    total = currentCartTotal.toString();

    emit(CartLocalUpdateState());

    try {
      var response = await CartRepo.updateToCart(cartItemId, quantity);

      if (response != null && response.data != null) {
        total = response.data!.total.toString();
        cartItems = response.data!.cartItems ?? [];
        _updateCartProductIds();

        emit(CartSuccessState(response.message.toString()));
      } else {
        _rollbackCart(targetItem, oldQuantity, oldItemTotal, oldCartTotal);
        emit(CartErrorState(response?.message ?? "Failed to update cart"));
      }
    } catch (e) {
      _rollbackCart(targetItem, oldQuantity, oldItemTotal, oldCartTotal);
      emit(CartErrorState(e.toString()));
    }
  }

  void _rollbackCart(
    CartItem item,
    int oldQty,
    double oldItemTotal,
    String oldCartTotal,
  ) {
    item.itemQuantity = oldQty;
    item.itemTotal = oldItemTotal;
    total = oldCartTotal;
    emit(CartLocalUpdateState());
  }

  Future<void> checkout() async {
    emit(CheckoutLoadingState());

    try {
      var response = await CartRepo.checkout();

      if (response != null && response.data != null) {
        emit(CheckoutSuccessState(response.message.toString()));
      } else {
        emit(CartErrorState(response?.message ?? "Failed to checkout"));
      }
    } catch (e) {
      emit(CartErrorState(e.toString()));
    }
  }
}
