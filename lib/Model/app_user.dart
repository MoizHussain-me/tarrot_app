import 'package:firebase_auth/firebase_auth.dart';
class AppUser {
  bool isNewUser;
  String phoneNumber;
  String uid;

  AppUser({
    required this.isNewUser,
    required this.phoneNumber,
    required this.uid,
  });

  factory AppUser.fromUserCredential(UserCredential userCredential) {
    final user = userCredential.user;

    return AppUser(
      isNewUser: userCredential.additionalUserInfo?.isNewUser ?? false,
      phoneNumber: user?.phoneNumber ?? '',
      uid: user?.uid ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isNewUser': isNewUser,
      'phoneNumber': phoneNumber,
      'uid': uid,
    };
  }

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      isNewUser: json['isNewUser'] ?? false,
      phoneNumber: json['phoneNumber'] ?? '',
      uid: json['uid'] ?? '',
    );
  }
}