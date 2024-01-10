import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Utils {

  static flushbarMessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.bounceIn,
        margin: const EdgeInsets.symmetric(horizontal: 29, vertical: 10),
        padding: const EdgeInsets.all(15),
        message: message,
        backgroundColor: Colors.black,
        duration: const Duration(seconds: 3),
        reverseAnimationCurve: Curves.easeOut,
        positionOffset: 20,
        // flushbarPosition: FlushbarPosition.TOP,
        icon: const Icon(Icons.error, size: 20, color: Colors.white),
      )..show(context),
    );
  }

  static snackBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.amber, content: Text(message)));
  }

  static void fieldfocuschange(
      BuildContext context, FocusNode current, FocusNode next) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  //Spaces
  static Widget addHorizontalSpace(double data) {
    return SizedBox(height: data);
  }

  static Widget addVerticalSpace(double data) {
    return SizedBox(width: data);
  }

//Divider
  static Widget myDivider() {
    return const Divider(
      thickness: 1,
      indent: 5,
      endIndent: 5,
    );
  }

//Reuseable Texts
  static Widget privacyPolicyText() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          color: Colors.white.withOpacity(0.9),
          fontSize: 12,
        ),
        children: [
          const TextSpan(text: 'By signing up you agree to Our '),
          TextSpan(
            text: 'Terms of Use',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white.withOpacity(0.9),
              decoration: TextDecoration.underline,
            ),
            // Add a callback for handling the 'Terms of Use' link
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Add your logic to navigate to the 'Terms of Use' page or perform any other action.
              },
          ),
          const TextSpan(text: ' and '),
          TextSpan(
            text: 'Privacy Policy',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white.withOpacity(0.9),
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
        ],
      ),
    );
  }
}
