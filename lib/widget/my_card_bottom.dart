import 'package:flutter/material.dart';

class MyCardBottom extends StatelessWidget {
  final void Function()? cartTap;
  final String btnText;
  final void Function()? iconTap;
  const MyCardBottom({super.key, required this.btnText, required this.cartTap,required this.iconTap,});

  @override
  Widget build(BuildContext context) {
    return Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        
                      ),
                      onPressed: cartTap,
                    child: Text(btnText)),
                  ),
                  IconButton(onPressed: iconTap , icon: Icon(Icons.favorite)),
                ],
              );
  }
}