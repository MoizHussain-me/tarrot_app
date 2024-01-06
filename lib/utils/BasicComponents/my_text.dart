import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyText extends StatelessWidget {
  MyText({super.key,required this.data,this.isHeading=false,this.isSelectable = false });

  final String data;
  bool isHeading;
  bool isSelectable;
  @override
  Widget build(BuildContext context) {
    return isSelectable ? Padding(
      padding: const EdgeInsets.all(5),
      child: SelectableText(
        data,
        textAlign: TextAlign.center,
        style: isHeading ? const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 25,
        )  :
        const TextStyle(color: Colors.white, fontSize: 16),
      ),
    ) :
    Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(
        data,
        style:isHeading ? const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 25,
        )  :
        const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}