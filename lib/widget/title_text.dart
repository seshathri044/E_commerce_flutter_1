import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String titleText;
  const TitleText({super.key,required this.titleText});

  @override
  Widget build(BuildContext context) {
    return Text(
      titleText,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey),);
  }
}