import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tarrot_app/ViewModel/shared_preferences_view_model.dart';
import 'package:tarrot_app/Views/Authentication/login_page.dart';
import 'package:tarrot_app/Views/Pages/dashboard_page.dart';

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

      customUserMap == null ? 
      Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_)=> const LoginPage())):
      Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_)=> const DashboardPage()));
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
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration:const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue,Colors.purple],
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