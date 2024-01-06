import 'package:flutter/material.dart';

class MyAssetImage extends StatelessWidget {
  const MyAssetImage({super.key,required this.data,required this.alignment});

  final String data;
  final AlignmentGeometry alignment;
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: alignment,
        child: Image(
          image: AssetImage('asset/images/$data'),
        ));
  }
}