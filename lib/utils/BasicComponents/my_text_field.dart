import 'package:flutter/material.dart';

TextEditingController textController = TextEditingController();

class MyTextField extends StatefulWidget {
  final String? Function(String?)? validator;
  final String hintText;
  final TextInputType inputType;

  const MyTextField({
    super.key,
    required this.hintText,
    required this.inputType,
    this.validator,
  });
  @override
  State<MyTextField> createState() => _MyTextFieldState();
  
  static String getTextFromTextField() {
    return textController.text;
  }
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        keyboardType: widget.inputType,
        controller: textController,
        validator: widget.validator,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText,
        ),
      ),
    );
  }
}
