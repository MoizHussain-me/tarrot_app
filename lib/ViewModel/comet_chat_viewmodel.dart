import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:flutter/material.dart';
import '../utils/app_strings.dart';

class CometChatViewModel with ChangeNotifier {
void initializeCometChat() {
  String region = AppStrings.region;
  String appId = AppStrings.appId;
  String authKey = AppStrings.authKey;

  AppSettings appSettings = (AppSettingsBuilder()
        ..subscriptionType = CometChatSubscriptionType.allUsers
        ..region = region
        ..adminHost = "" //optional
        ..clientHost = "" //optional
        ..autoEstablishSocketConnection = true)
      .build();

  CometChat.init(appId, appSettings, onSuccess: (String successMessage) {
    debugPrint("Initialization completed successfully  $successMessage");
  }, onError: (CometChatException excep) {
    debugPrint("Initialization failed with exception: ${excep.message}");
  });

  // Create User Initializer

  UIKitSettings uiKitSettings = (UIKitSettingsBuilder()
        ..subscriptionType = CometChatSubscriptionType.allUsers
        ..autoEstablishSocketConnection = true
        ..region = region
        ..appId = appId //replace with your app Id
        ..authKey = authKey
        ..callingExtension = CometChatCallingExtension()
        ..extensions = CometChatUIKitChatExtensions
            .getDefaultExtensions()) //replace with your auth Key
      .build();
  CometChatUIKit.init(
      uiKitSettings: uiKitSettings,
      onSuccess: (String successMessage) {
        debugPrint("Initialization completed successfully  $successMessage");
      },
      onError: (CometChatException e) {
        debugPrint("Initialization failed with exception: ${e.message}");
      });

//Call Initializer

  CallAppSettings callAppSettings = (CallAppSettingBuilder()
        ..appId = appId
        ..region = AppStrings.region
      //..host = "xxxxxxxxx"
      )
      .build();

  CometChatCalls.init(callAppSettings, onSuccess: (String successMessage) {
    debugPrint("Initialization completed successfully  $successMessage");
  }, onError: (CometChatCallsException e) {
    debugPrint("Initialization failed with exception: ${e.message}");
  });
}

Future<void> loginCometChatUser(String id) async {
  final user = await CometChat.getLoggedInUser();

  if (user == null) {
    await CometChat.login(id, AppStrings.authKey, onSuccess: (User user) {
      debugPrint("Login Successful : $user");
    }, onError: (CometChatException e) {
      debugPrint("Login failed with exception:  ${e.message}");
    });
  }
}

void registerCometchatUser(String name, String id) {
  CometChatUIKit.createUser(User(name: name, uid: id), onSuccess: (User user) {
    debugPrint("User created successfully ${user.name}");
  }, onError: (CometChatException e) {
    debugPrint("Creating new user failed with exception: ${e.message}");
  });
}

void LogoutCometChatUser() {
  CometChat.logout(onSuccess: (successMessage) {
    debugPrint("Logout successful with message $successMessage");
  }, onError: (CometChatException e) {
    debugPrint("Logout failed with exception:  ${e.message}");
  });
}

void sendMessage(String msg, String receiverId) {
  String receiverID = receiverId;
  String messageText = msg;
  String receiverType = CometChatConversationType.user;
  String type = CometChatMessageType.text;

  TextMessage textMessage = TextMessage(
      text: messageText,
      receiverUid: receiverID,
      receiverType: receiverType,
      type: type);
  CometChat.sendMessage(textMessage, onSuccess: (TextMessage message) {
    debugPrint("Message sent successfully:  $message");
  }, onError: (CometChatException e) {
    debugPrint("Message sending failed with exception:  ${e.message}");
  });
}

Future<void> ImageMessageCometChat(String imgPath, String receiverId) async {
  String messageType = CometChatMessageType.image;
  String receiverType = CometChatConversationType.user;
  MediaMessage mediaMessage = MediaMessage(
      receiverType: receiverType,
      type: messageType,
      receiverUid: receiverId,
      file: null);

  String fileUrl = imgPath;
  String fileName = "test";
  String fileExtension = "png";
  String fileMimeType = "image/png";

  Attachment attach =
      Attachment(fileUrl, fileName, fileExtension, fileMimeType, null);
  mediaMessage.attachment = attach;

  await CometChat.sendMediaMessage(mediaMessage,
      onSuccess: (MediaMessage message) {
    debugPrint("Media message sent successfully: ${mediaMessage}");
  }, onError: (CometChatException e) {
    debugPrint("Media message sending failed with exception: ${e.message}");
  });
}


void unreadMessagesCometChat(String id) {
  int limit = 30;
  int lastMessageId = 1;
// String GUID = "superhero1";

  MessagesRequest messageRequest = (MessagesRequestBuilder()
        // ..guid = id
        ..uid = id
        ..limit = limit
        ..messageId = lastMessageId
        ..unread = true)
      .build();

  messageRequest.fetchPrevious(onSuccess: (List<BaseMessage> list) {
    for (BaseMessage message in list) {
      if (message is TextMessage) {
        debugPrint("Text message received successfully: $message");
      } else if (message is MediaMessage) {
        debugPrint("Media message received successfully: $message");
      }
    }
  }, onError: (CometChatException e) {
    debugPrint("Message fetching failed with exception: ${e.message}");
  });
}

void messageHistoryCometChat(String id) {
  int limit = 30;
  int lastMessageId = 1;
  String UID = id;

  MessagesRequest messageRequest = (MessagesRequestBuilder()
        ..uid = UID
        ..limit = limit)
      .build();

  messageRequest.fetchPrevious(onSuccess: (List<BaseMessage> list) {
    for (BaseMessage message in list) {
      if (message is TextMessage) {
        debugPrint("Text message received successfully: $message");
      } else if (message is MediaMessage) {
        debugPrint("Media message received successfully: $message");
      }
    }
  }, onError: (CometChatException e) {
    debugPrint("Message fetching failed with exception: ${e.message}");
  });
}

void retrieveConvoCometChat(String id) {
  String conversationWith = id;
  String conversationType = "user";
  CometChat.getConversation(conversationWith, conversationType,
      onSuccess: (Conversation conversation) {
    debugPrint("Fetch Conversation Successfully : $conversation");
  }, onError: (CometChatException e) {
    debugPrint("Fetch Conversation  failed  : ${e.message}");
  });
}

void audioCallCometchat(
    String Recid, String userId, String name, BuildContext context) {
  String receiverID = Recid;
  String receiverType = "user";
  String callType = "audio";

  Call call =
      Call(receiverUid: receiverID, receiverType: receiverType, type: callType);

  CometChat.initiateCall(call, onSuccess: (Call call) {
    debugPrint("Initiated");
    debugPrint(call.sessionId);

    User currentUser = User(uid: userId, name: name);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CometChatIncomingCall(
          call: call,
          user: currentUser,
          subtitle: 'Incoming Call',
          declineButtonText: 'Decline',
          acceptButtonText: 'Accept',
          onAccept: (context, call) {
            acceptCall(call.sessionId.toString());

            Navigator.pop(context);
            CallSettingsBuilder callSettingsBuilder = (CallSettingsBuilder()
              ..enableDefaultLayout = true
              ..setAudioOnlyCall = true
              ..enableVideoTileClick = false
              ..setSingleMode = true
              ..showCallRecordButton = false
              ..showMuteAudioButton = false);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CometChatOngoingCall(
                  callSettingsBuilder: callSettingsBuilder,
                  sessionId: call.sessionId.toString(),
                  callWorkFlow: CallWorkFlow.directCalling,
                ),
              ),
            );
          },
          onDecline: (context, call) {
            rejectCall(call.sessionId.toString());
          },
        ),
      ),
    );
  }, onError: (CometChatException e) {
    debugPrint("Error: $e");
  });
}

void acceptCall(String sessionId) {
  String sessionID = sessionId;
  CometChat.acceptCall(sessionId, onSuccess: (Call call) {
    debugPrint("Accepted ");
    debugPrint("Accepted  ");
    debugPrint("Accepted    ");
  }, onError: (CometChatException e) {
    debugPrint("Error: ${e.message}");
  });
}

void rejectCall(String ssId) {
  String sessionID = ssId;
  String status = "reject";

  CometChat.rejectCall(sessionID, status, onSuccess: (Call call) {
    debugPrint("Rejected");
  }, onError: (CometChatException e) {
    debugPrint("Error: ${e.message}");
  });
}
}