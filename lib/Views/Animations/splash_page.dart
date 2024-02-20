import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tarrot_app/ViewModel/shared_preferences_viewmodel.dart';
import 'package:tarrot_app/Views/Authentication/Login/login_page.dart';
import 'package:tarrot_app/utils/Layout/app_layout.dart';
import '../../ViewModel/cometchat_viewmodel.dart';

class SplashPage extends StatefulWidget  {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}
class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
 @override
  void initState() {
    super.initState();
    // yeh screen ko full screen karney k liye 
    //uper status bar aur neechy buttons hide karnye k liye
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 2),() async{
    Map<String, dynamic>? customUserMap = await SharedPreferencesHelper.getObject<Map<String, dynamic>>('user');  
    if(customUserMap == null)
    {
      if (!context.mounted) return;
      Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_)=> const LoginPage()));
    }
    else{
      CometChatUIKit.login(customUserMap["uid"], onSuccess: (user)async {
      debugPrint("User Logged In");
      await SharedPreferencesHelper.setObject('user', user.toJson());
      if (!context.mounted) return;
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MyAppLayout()));
      });
    }
    }
    );
  }

  @override
  void dispose() {
    super.dispose();
    //wapis normal karny k liye
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
        final cometChatViewModel = Provider.of<CometChatViewModel>(context);
        cometChatViewModel.initializer();
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration:const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange,Colors.red],
          begin: Alignment.topRight,
          end:  Alignment.bottomLeft)),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: 
              AssetImage('asset/icons/tarot_cards.png'),
              height: 150),
              SizedBox(height: 30,),
              Text("Tarrot Card App",style: TextStyle(
                fontSize: 35,
                color: Colors.white,
                ),
                ),
                
              Padding(
                padding: EdgeInsets.all(40.0),
                child: LinearProgressIndicator()) 
            ]),
          ),
    );
  }
}