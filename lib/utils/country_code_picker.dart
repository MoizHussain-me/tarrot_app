// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';

String phonecode = "";
class CountryCodePicker extends StatefulWidget {
  const CountryCodePicker({Key? key}) : super(key: key);
  @override
  State<CountryCodePicker> createState() => _CountryCodePickerState();
}
class _CountryCodePickerState extends State<CountryCodePicker> {
   String getcounCode() {
    return phonecode.toString();
  }
  String countrycode = "";
  String flgurl = "";
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          showCountryPicker(
            context: context,
            showPhoneCode: true,
            onSelect: (Country country) {
              debugPrint('Select country: ${country.displayName}');
              debugPrint(country.countryCode.toString());
              debugPrint(country.phoneCode.toString());
              debugPrint(country.flagEmoji);
              countrycode = country.phoneCode.toString();
              flgurl = country.flagEmoji;
              setState(() {
                phonecode = country.phoneCode.toString();
              });
            },
          );
        },
        child: Row(
          children: [
            Text(flgurl),
            const SizedBox(width: 3),
            Text(
              '+ $countrycode',
              style: const TextStyle(color: Colors.grey),
            ),
            const Icon(
              Icons.arrow_drop_down,
              color: Colors.grey,
            ),
          ],
        ));
  }
}
