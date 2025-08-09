import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/models/product.dart';
import 'package:flutter_e_commerce/pages/detial_page.dart';
import 'package:flutter_e_commerce/services/cart_provider.dart';
import 'package:flutter_e_commerce/widget/title_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Product> dummyProducts =[
      Product(id: "1", title: "Wireless HeadPhones", description: "description", imgurl: "images/headphone.jpg", price: "800"),
      Product(id: "2", title: "Smart Watch", description: "description", imgurl: "https://m.media-amazon.com/images/I/41jJtitW+KL._SY300_SX300_.jpg", price: "1000"),
      Product(id: "3", title: "Gaming Mouse", description: "description", imgurl: "https://m.media-amazon.com/images/I/61qN9d08hgL.jpg", price: "1500"),
      Product(id: "4", title: "Shirt for Men", description: "description", imgurl: "https://cottonfolk.in/cdn/shop/files/Men_sBrownPinstripeShort-SleeveShirt.jpg?v=1732268509", price: "648"),
      Product(id: "5", title: "Luffy Straw Hat", description: "description", imgurl: "https://m.media-amazon.com/images/I/71Gz3g056UL.jpg", price: "1200")


    ];
    return Consumer(
      builder : (context,ref,child) {
        final cart = ref.watch(cartProvider);
        final cartList = cart.values.toList();
        final cartNotifier = ref.read(cartProvider.notifier);
        return Scaffold(
        appBar: AppBar(title: Text("Shop App"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                
              },
              child: Badge(
                label: Text(cartList.length.toString()),
                child: Icon(Icons.shopping_cart))),
          ),
        ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TitleText(titleText: "Latest Products"),
                  GestureDetector(
                    onTap: () {
                      
                    },
                    child: TitleText(titleText: "See All"))
                ],
               ),
               SizedBox(height: 15,),
               SizedBox(
                height: 260,
                 child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: dummyProducts.length,
                  itemBuilder: (context , index){
                    final product = dummyProducts[index];
                  return Container(
                    width: 160,
                    margin: EdgeInsets.only(right: 7),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                      ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(8),
                          child: GestureDetector(
                            onTap:() {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> DetialPage(product: product),));
                            },
                            child: Image.network(product.imgurl , height: 140,fit: BoxFit.cover,
                                        
                            width: double.infinity,
                            ),
                          ),
                        ),
                        SizedBox(height: 7,),
                        TitleText(titleText: product.title),
                        SizedBox(height: 7,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(double.parse(product.price).toStringAsFixed(2), 
                            style: TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold),),


                            GestureDetector(
                              onTap: cart.containsKey(product.id)? null: () {
                                cartNotifier.addProduct(product);
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text("product added to the crt")));
                              },
                              child: Container(
                                padding: EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  color: cart.containsKey(product.id)? Colors.green : Colors.grey.shade300, 
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  cart.containsKey(product.id) ? Icons.check :
                                  Icons.shopping_cart),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                 }),
               ),
               SizedBox(height: 10,),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TitleText(titleText: "All Products"),
                  GestureDetector(
                    onTap: () {
                      
                    },
                    child: TitleText(titleText: "See All"))
                ],
               ),
               SizedBox(height: 10),
               GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 270),
               physics: NeverScrollableScrollPhysics(),
               shrinkWrap: true,
               itemCount:  dummyProducts.length,
                itemBuilder: (context, index) {
                  final product = dummyProducts[index];
                 return Container(
                  margin: EdgeInsets.only(right: 7,bottom: 7),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey,borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> DetialPage(product: product),));
                        },
                        child: Image.network(product.imgurl,height : 160,width : double.infinity, fit: BoxFit.cover)),
                      SizedBox(height: 8,),
                      TitleText(titleText: product.title),
                      SizedBox(height: 8),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Text(double.parse(product.price).toStringAsFixed(2),
                            style: TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold),),
                            GestureDetector(
                              onTap: cart.containsKey(product.id)? null: () {
                                cartNotifier.addProduct(product);
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text("product added to the crt")));
                              },
                              child: Container(
                                padding: EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  color: cart.containsKey(product.id)? Colors.green : Colors.grey.shade300, 
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  cart.containsKey(product.id) ? Icons.check :
                                  Icons.shopping_cart),
                              ),
                            ),
                        ],
                      )
                    ],
                  )
            
                 );
               },
               
               )
              ],
            ),
          ),
        )
      );
      },
    );
  }
}