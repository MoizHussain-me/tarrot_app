import 'package:flutter/material.dart';

import '../app_strings.dart';
import '../country_code_picker.dart';
import 'my_text_field.dart';

class NumberFieldWithCountryCode extends StatefulWidget {
    final String? Function(String?)? validator;
  const NumberFieldWithCountryCode(  {super.key,this.validator,});

  @override
  State<NumberFieldWithCountryCode> createState() => _NumberFieldWithCountryCodeState();
}

class _NumberFieldWithCountryCodeState extends State<NumberFieldWithCountryCode> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
           const CountryCodePicker(),
          const SizedBox(height: 10),
          MyTextField(hintText: AppStrings.hintNumber,inputType:TextInputType.number,validator: widget.validator,)
        ],
      ),
    );
  }
}