import 'package:flutter_e_commerce/models/product.dart';

class CartModel {
  final Product product;
  final int quantity;
  CartModel({required this.product, required this.quantity});
  CartModel copyWith({int ? quantity}){
    return CartModel(product: product, quantity: quantity?? this. quantity);
  }

}