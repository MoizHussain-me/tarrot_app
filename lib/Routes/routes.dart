import 'package:flutter/material.dart';
import 'package:tarrot_app/Routes/routes_name.dart';
import 'package:tarrot_app/Views/Animations/splash_page.dart';
import 'package:tarrot_app/Views/Authentication/login/login_page.dart';
import 'package:tarrot_app/Views/Authentication/otp_verification/otp_page.dart';
import 'package:tarrot_app/Views/Pages/dashboard/dashboard_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.login:
        return MaterialPageRoute(
            builder: (_) => const LoginPage());
      case RouteName.otp:
        var id, phone;
        return MaterialPageRoute(
            builder: (_) => OtpPage(
                  verificationId: id,
                  phoneNum: phone,
                ));
      case RouteName.splash:
        return MaterialPageRoute(
            builder: (_) => const SplashPage());

      case RouteName.dashboard:
        return MaterialPageRoute(
            builder: (_) => const DashboardPage());
      
      // case RouteName.ChatScreen:
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => const DashboardScreen());


      // case RouteName.registerProfile:
      //   var phone;
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => RegisterProfile(
      //             phoneNum: phone,
      //           ));

      // case RouteName.listReaders:
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => const TarrotCardList());

      // case RouteName.profile:
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => const profile_page());

      // case RouteName.setting:
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => const settingPage());

      // case RouteName.splash:
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => const splashscreen());

      // case RouteName.myAppLayout:
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => const MyAppLayout());

      // case RouteName.waitforapproval:
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => const WaitForApproval());

      // case RouteName.admindashboard:
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => const Admin_Dashboard());

      // case RouteName.conversationpage:
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => const ConversationPage());

      default:
        return MaterialPageRoute(
          builder: (_) {
            return const Scaffold(
              body: Center(
                child: Text('No Route Found'),
              ),
            );
          },
        );
    }
  }
}
