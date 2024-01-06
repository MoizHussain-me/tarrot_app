// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';

class SignInField extends StatelessWidget {
    final TextEditingController controller; // Add this line
  int pin;
  SignInField({super.key, required this.pin, required this.controller});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      width: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: TextFormField(
          controller: controller,
          autofocus: true,
          keyboardType: TextInputType.number,
          maxLength: 1,
          onSaved: (pin$pin) {},
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            filled: true,
            fillColor: Colors.white,
            counterText: "",
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),

    );
  }

   String getTextFromTextField() {
    return controller.text;
  }
}
