import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyButton extends StatelessWidget {
  MyButton(
      {super.key,
      required this.data,
      required this.callback,
      this.isOutlined = false,
      this.icon});

  final Function() callback;
  final String data;
  bool isOutlined;
  IconData? icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        height: 40,
        width: double.infinity,
        decoration: isOutlined
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.white, width: 2))
            : BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(15),
              ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Icon(
                        icon,
                        size: 30,
                        color: Colors.white,
                      ),
                    )
                  : Container(),
              Expanded(
                flex: 3,
                child: Text(
                  data,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    letterSpacing: 2.0,
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Poppins Medium',
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
