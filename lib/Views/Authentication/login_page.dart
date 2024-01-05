import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarrot_app/ViewModel/auth_view_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneController =  TextEditingController();
  @override
  Widget build(BuildContext context) {
   final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              controller: phoneController,
              keyboardType: TextInputType.number,
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(onPressed:() {
           authViewModel.sendOtp('+923332245310', context);
          }, child:const Text("Verify"))
      ]),
    );
  }
}