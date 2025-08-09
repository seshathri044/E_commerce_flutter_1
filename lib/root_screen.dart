import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/pages/cart_page.dart';
import 'package:flutter_e_commerce/pages/home_page.dart';
import 'package:flutter_e_commerce/services/cart_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
   int selectedIndex =0;
   List body =[
    HomePage(),
    CartPage(),
    Center(
      child: Text("WishList"),
    ),
    Center(
      child: Text("Profile Page"),
    )
   ];

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder:(context, ref, child) {
        final cart = ref.watch(cartProvider);
        final cartItems = cart.values.toList();
        return Scaffold(
        bottomNavigationBar: NavigationBar(destinations: [
          NavigationDestination(icon: Icon(Icons.home_max_outlined), label: "Home"),
          NavigationDestination(
            icon: selectedIndex ==1 
            ? Icon(Icons.shopping_cart)
            : Badge(
            label: Text(cartItems.length.toString()),
            child: Icon(Icons.shopping_cart),), label: "cart"),
          NavigationDestination(icon: Icon(Icons.favorite), label: "WishList"),
          NavigationDestination(icon: Icon(Icons.person), label: "profile"),
        ],
        selectedIndex: selectedIndex,
        onDestinationSelected: (value){
          setState(() {
            selectedIndex = value;
          });
        },
        ),
        body: body[selectedIndex],
      );
      },
    );
  }
}