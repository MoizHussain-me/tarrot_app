import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseUser;
import 'package:flutter/material.dart';
import 'package:tarrot_app/Model/user_model.dart';
import 'package:tarrot_app/ViewModel/shared_preferences_viewmodel.dart';
import '../Views/Authentication/otp_verification/otp_page.dart';
import '../utils/Layout/app_layout.dart';

class AuthViewModel with ChangeNotifier {
  final _auth = firebaseUser.FirebaseAuth.instance;

  void sendOtp(String phoneNumber, BuildContext context) {
    _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted:
            (firebaseUser.PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          debugPrint('verification Failed : $e');
        },
        codeSent: (String verificationId, int? token) {
          debugPrint(
              'verification Id & token : $verificationId   token : $token');

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
    final credential = firebaseUser.PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otp);
    await _auth.signInWithCredential(credential).then((value) async {
      debugPrint("Alaaaad  $value");
      UserModel customUser = UserModel.fromUser(value);
      await loginUser(customUser, context);
    });
  }

  Future<void> loginUser(User customUser, BuildContext context) async {
    await SharedPreferencesHelper.setObject('user', customUser.toJson());
    CometChatUIKit.login(customUser.uid, onSuccess: (user) {
      debugPrint("User Logged In");
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MyAppLayout()));
    }, onError: (err) async {
      if (err.code == "ERR_UID_NOT_FOUND") {
        await CometChatUIKit.createUser(customUser, onSuccess: (u) async {
          await loginUser(u, context);
        });
      }
    });
  }
}
