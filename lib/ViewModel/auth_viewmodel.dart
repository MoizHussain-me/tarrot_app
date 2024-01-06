import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tarrot_app/Model/app_user.dart';
import 'package:tarrot_app/ViewModel/shared_preferences_viewmodel.dart';
import '../Views/Authentication/otp_verification/otp_page.dart';

class AuthViewModel with ChangeNotifier {
  final _auth = FirebaseAuth.instance;

  void  sendOtp (String phoneNumber , BuildContext context) {
    _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
           await _auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
            debugPrint('verification Failed : $e');
        },
        codeSent: (String verificationId, int? token) {
            debugPrint('verification Id & token : $verificationId   token : $token');
            
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (builder) => OtpPage(
                      verificationId: verificationId, phoneNum: phoneNumber)));
        },
        codeAutoRetrievalTimeout: (e) {
           debugPrint('TimeOut : $e');
        });
  }

  void verifyOtp(String verificationId, String otp, String phoneNum,
      BuildContext context) async {
    final credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otp);
      await _auth.signInWithCredential(credential).then((value) async {
      debugPrint("Alaaaad  $value");
      AppUser customUser = AppUser.fromUserCredential(value);
      await SharedPreferencesHelper.setObject('user', customUser.toJson());
      });
    
  }
}
