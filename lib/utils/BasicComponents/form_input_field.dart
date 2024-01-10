import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String label, hint;
  final bool isReadOnly;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const MyTextField({
    required this.label,
    required this.hint,
    required this.isReadOnly,
    this.validator,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    //double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 30),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: SizedBox(
                    width: 200,
                    child: TextFormField(
                    
                      validator: validator,
                      controller: controller,
                      readOnly: isReadOnly,
                      style: const TextStyle(height: 1),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: hint,
                        hintStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff9A9A9A),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
