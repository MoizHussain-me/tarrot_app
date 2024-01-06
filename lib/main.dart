import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarrot_app/Routes/routes.dart';
import 'package:tarrot_app/Routes/routes_name.dart';
import 'package:tarrot_app/ViewModel/auth_viewmodel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'ViewModel/dashboard_viewmodel.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => DashboardViewModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: RouteName.dashboard,
        onGenerateRoute: Routes.generateRoute,
      
    ));
  }
}


