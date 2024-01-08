import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseUser;
import 'package:flutter/material.dart';
import 'package:tarrot_app/Model/role_enum.dart';

class UserModel extends User {
  UserModel(
      {super.uid = "",
      required super.name,
      super.avatar,
      super.link,
      super.role,
      super.status,
      super.statusMessage,
      super.lastActiveAt,
      super.tags,
      super.metadata,
      super.hasBlockedMe,
      super.blockedByMe});


  factory UserModel.fromUser(firebaseUser.UserCredential userCredential) {
    final user = userCredential.user;
    return UserModel(
      role: null,
      metadata: {
        "PhoneNumber": user?.phoneNumber ?? '',
      },
      uid: user?.uid ?? '',
      name: 'User',
      avatar: null,
      blockedByMe: false,
      hasBlockedMe: false,
      lastActiveAt: DateTime.now(),
      link: null,
      status: null,
      statusMessage: null,
      tags: null
    );
  }

 Future<bool> updateUser(String uid, UserModel obj) async {
    await CometChat.getUser(uid, onSuccess: (User user) async {
      user.name= obj.name;
      user.avatar = obj.avatar;
      user.metadata = obj.metadata;
      user.role = obj.role;
      
      await CometChatUIKit.updateUser(user, onSuccess: (User retUser){
        debugPrint('User updated successfully: $retUser');
        return true;
      }, onError: (CometChatException excep) {  });
    }, onError: (CometChatException excep) {
      debugPrint('Error fetching user by UID: $excep');
      return false;
    });
    return false;
}

}
