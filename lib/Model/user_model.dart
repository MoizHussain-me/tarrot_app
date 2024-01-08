import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseUser;
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


  factory UserModel.fromTarrotUser(firebaseUser.UserCredential userCredential) {
    final user = userCredential.user;
    return UserModel(
      role: RoleEnum.User.toString(),
      metadata: {
        "PhoneNumber": user?.phoneNumber ?? '',
      },
      uid: user?.uid ?? '',
      name: '',
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





}
