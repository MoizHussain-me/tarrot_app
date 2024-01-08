import 'dart:async';

import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:cometchat_sdk/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseUser;
import 'package:flutter/material.dart';
import 'package:tarrot_app/Model/user_model.dart';
import 'package:tarrot_app/ViewModel/shared_preferences_viewmodel.dart';
import 'package:tarrot_app/utils/app_strings.dart';
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

      bool check = await registerCometchatUser(value.additionalUserInfo!.username.toString(), value.user!.uid.toString());
//       CometChat.createUser(customUser, AppStrings.authKey, onSuccess: (user) async{

// await SharedPreferencesHelper.setObject('user', user.toJson());
      check
          ? Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const MyAppLayout()))
          : " ";

//       },
//       onError: (err){
//         debugPrint("Agar kuch hai tu bata do $err");
//       });
    });
  }

  Future<bool> registerCometchatUser(String name, String id) async {
    Completer<bool> completer = Completer<bool>();

    CometChatUIKit.createUser(User(name: name, uid: id),
        onSuccess: (User user) {
      debugPrint("User created successfully ${user.name}");
      completer.complete(true);
    }, onError: (CometChatException e) {
      debugPrint("Creating new user failed with exception: ${e.message}");
      completer.complete(false);
    });

    return completer.future;
  }
}
