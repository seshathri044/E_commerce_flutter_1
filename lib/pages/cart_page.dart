import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/services/cart_provider.dart';
import 'package:flutter_e_commerce/widget/my_card_bottom.dart';
import 'package:flutter_e_commerce/widget/title_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartPage extends StatelessWidget {
  const CartPage ({super.key});

  @override
  Widget build(BuildContext context) {
    int deliveryPrice =200;
    return Consumer(
      builder: (context, ref, child) {

        final cart = ref.watch(cartProvider);
        final cartItems = cart.values.toList();
        final cartNotifier = ref.watch(cartProvider.notifier);
        final totalPrice = cartNotifier.totalPrice;
        final totalQuantity = cartNotifier.totalQuantity;
        return cart.isEmpty ? Scaffold(
          appBar: AppBar(


          ),
          body: Center(
            child: Text("Your Cart is Empty"),
          ),
          ):
           Scaffold(
        appBar: AppBar(
          title: Text("All Products in your cart ",style:  TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
          actions: [
            IconButton(onPressed: () {
              cartNotifier.clearCart();
            }, icon: Icon(Icons.delete))],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final cartItem = cartItems[index];
                return Dismissible(
                  key: Key(cartItem.product.id),
                  direction: DismissDirection.endToStart,
                  onDismissed:(direction) {
                    cartNotifier.removeProduct(cartItem.product);
                  },
                  child: ListTile(
                    title: TitleText(titleText: cartItem.product.title),
                    subtitle: Text("\$ ${cartItem.product.price}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: (){
                          cartNotifier.decreaseQuantity(cartItem.product);
                        }, icon: Icon(Icons.remove)),
                        TitleText(titleText: cartItem.quantity.toString()),
                        IconButton(onPressed: (){
                          cartNotifier.increaseQuantity(cartItem.product);
                        }, icon: Icon(Icons.add)),
                      ],
                    ),
                  ),
                );
              },)
            ],
          ),
        ),
        bottomSheet: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TitleText(titleText: "Total Products: ${cartItems.length}"),
                TitleText(titleText: "Total quantity: $totalQuantity"),
                TitleText(titleText: "Delivery Price: $deliveryPrice"),
                TitleText(titleText: "All Product Price : \$ ${(totalPrice).toStringAsFixed(2)}"),
                Divider(),
                TitleText(titleText: "Total Price : \$ ${(totalPrice + deliveryPrice).toStringAsFixed(2)}"),
                Divider(),
                MyCardBottom(btnText: "Order Now", cartTap: (){}, iconTap: (){},
                
                ),
              ],
            ),
          ),
        ),
      );
      },
    );
  }
}