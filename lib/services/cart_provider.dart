import 'package:flutter_e_commerce/models/cart_model.dart';
import 'package:flutter_e_commerce/models/product.dart';
import 'package:riverpod/riverpod.dart';

class CartNotifier extends Notifier<Map<String, CartModel>> {
  @override
  Map<String, CartModel> build() {
    return {};
  }

  // add product if it is not in the cart 
  void addProduct(Product product) {
    Map<String, CartModel> copystate() => {...state};
    final stateMap = copystate();
    if (state.containsKey(product.id)) return;
    stateMap[product.id] = CartModel(product: product, quantity: 1);
    state = stateMap;
  }

  // increase Quantity existing product 
  void increaseQuantity(Product product) {
    Map<String, CartModel> copystate() => {...state};
    final stateMap = copystate();
    if (!state.containsKey(product.id)) return;
    final cartItem = stateMap[product.id]!;
    stateMap[product.id] = cartItem.copyWith(quantity: cartItem.quantity + 1);
    state = stateMap;
  }

  // decrease Quantity existing product 
  void decreaseQuantity(Product product) {
    Map<String, CartModel> copystate() => {...state};
    final stateMap = copystate();
    if (!state.containsKey(product.id)) return;
    final cartItem = stateMap[product.id]!;
    if (cartItem.quantity > 1) {
      stateMap[product.id] =
          cartItem.copyWith(quantity: cartItem.quantity - 1);
    }
    state = stateMap;
  }

  // remove product from cart
  void removeProduct(Product product) {
    Map<String, CartModel> copystate() => {...state};
    final stateMap = copystate();
    if (state.containsKey(product.id)) {
      stateMap.remove(product.id);
    }
    state = stateMap;
  }

  // clear carts
  void clearCart() {
    state = {};
  }

  // calculate total price
  double get totalPrice {
    return state.values.fold<double>(
      0.0,
      (previousValue, element) =>
          previousValue +
          (element.quantity *
              (element.product.price is num
                  ? element.product.price as num
                  : double.tryParse(element.product.price.toString()) ?? 0.0)),
    );
  }

  // calculate the total quantity of all products
  int get totalQuantity {
    return state.values.fold(
      0,
      (previousValue, element) => previousValue + element.quantity,
    );
  }
}
//declare a global accessible riverpod here
final cartProvider = NotifierProvider<CartNotifier, Map<String,CartModel>>(CartNotifier.new,);
