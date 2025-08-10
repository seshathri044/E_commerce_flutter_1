import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/models/product.dart';
import 'package:flutter_e_commerce/services/cart_provider.dart';
import 'package:flutter_e_commerce/widget/my_card_bottom.dart';
import 'package:flutter_e_commerce/widget/title_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetialPage extends StatelessWidget {
  final Product  product;
  const DetialPage({super.key,required this.product});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final cart = ref.watch(cartProvider);
        final cartNotifier = ref.watch(cartProvider.notifier);
        
        return Scaffold(
        appBar: AppBar(
      
        ),
        body: Padding(

          
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(12),
                  child: Image.network(product.imgurl, width: double.infinity, height: 400, fit: BoxFit.fill,)),
                SizedBox(height: 15),
                TitleText(titleText: product.title),
                SizedBox(height: 12,),
                Text(product.description * 30),
                SizedBox(height: 150),
              ],
            ),
          ),
        ),
        bottomSheet: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleText(titleText: "Product Price: ${product.price.toString()}"),
                SizedBox(height: 12),
                MyCardBottom(btnText: cart.containsKey(product.id) ? "Added to Cart" : "Add to Cart", 
                cartTap: cart.containsKey(product.id)? null :(){
                  cartNotifier.addProduct(product);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Product Added to the cart")),);
                }, iconTap: (){},),
              ],
            ),
          ),
        ),
      );
      },
    );
  }
}