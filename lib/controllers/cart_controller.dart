import 'package:get/get.dart';
import 'package:task_app/models/cart_model.dart';
import 'package:task_app/models/food_menu_data_model.dart';

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;

  void addToCart(MenuItem item) {
    final existing = cartItems.firstWhereOrNull(
      (e) => e.item.disName == item.disName,
    );
    if (existing != null) {
      existing.quantity++;
      cartItems.refresh();
    } else {
      cartItems.add(CartItem(item: item));
    }
  }

  void increaseQuantity(CartItem cartItem) {
    cartItem.quantity++;
    cartItems.refresh();
  }

  void decreaseQuantity(CartItem cartItem) {
    if (cartItem.quantity > 1) {
      cartItem.quantity--;
    } else {
      cartItems.remove(cartItem);
    }
    cartItems.refresh();
  }

  double get totalPrice => cartItems.fold(
    0,
    (sum, e) => sum + e.quantity * (e.item.mediumPrice), // pick the price tier
  );
}
