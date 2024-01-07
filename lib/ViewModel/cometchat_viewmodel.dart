import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:flutter/material.dart';
import 'package:tarrot_app/utils/app_strings.dart';

import '../CometChat/utils/demo_meta_info_constants.dart';

class CometChatViewModel with ChangeNotifier{

initializer(){
   AppSettings appSettings = (AppSettingsBuilder()
          ..subscriptionType = CometChatSubscriptionType.allUsers
          ..region = AppStrings.region
          
          ..autoEstablishSocketConnection = true)
        .build();
    
    CometChat.init(AppStrings.appId, appSettings,
        onSuccess: (String successMessage) {
      debugPrint("Initialization completed successfully  $successMessage");
    }, onError: (CometChatException excep) {
      debugPrint("Initialization failed with exception: ${excep.message}");
    });


//Chat Ui Initializer 

    UIKitSettings uiKitSettings = (UIKitSettingsBuilder()
          ..subscriptionType = CometChatSubscriptionType.allUsers
          ..region = AppStrings.region
          ..autoEstablishSocketConnection = true
          ..appId = AppStrings.appId
          ..authKey = AppStrings.authKey
          ..callingExtension = CometChatCallingExtension()
          ..extensions = CometChatUIKitChatExtensions.getDefaultExtensions()
          ..aiFeature = [
            AISmartRepliesExtension(),
            AIConversationStarterExtension(),
            AIAssistBotExtension(),
            AIConversationSummaryExtension()
          ])
        .build();

    CometChatUIKit.init(
      uiKitSettings: uiKitSettings,
      onSuccess: (successMessage) {
        try {
          CometChat.setDemoMetaInfo(jsonObject: {
            "name": DemoMetaInfoConstants.name,
            "type": DemoMetaInfoConstants.type,
            "version": DemoMetaInfoConstants.version,
            "bundle": DemoMetaInfoConstants.bundle,
            "platform": DemoMetaInfoConstants.platform,
          });
        } catch (e) {

            debugPrint("setDemoMetaInfo ended with error");
        }
      },
    );


}



  loginUser(String userId) async {
    // ToastContext().init(context); //Replace with name and uid of user
    User? _user = await CometChat.getLoggedInUser();
    try {
      if (_user != null) {
        await CometChatUIKit.logout();
      }
    } catch (_) {}

    await CometChatUIKit.login(userId, onSuccess: (User loggedInUser) {
      debugPrint("Login Successful : $loggedInUser");
      _user = loggedInUser;
    }, onError: (CometChatException e) {
      debugPrint("Login failed with exception:  ${e.message}");
      // Toast.show("Login failed",
      //     duration: Toast.lengthShort, gravity: Toast.bottom);
    });
  }


}