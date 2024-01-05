import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarrot_app/ViewModel/auth_viewmodel.dart';

class OtpPage extends StatefulWidget {
  final String verificationId;
  final String phoneNum;
  const OtpPage({super.key, required this.verificationId, required this.phoneNum});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
 
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
            authViewModel.verifyOtp(widget.verificationId, phoneController.text.toString(), widget.phoneNum, context);
          }, child:const Text("Otp Button"))
      ]),
    );
  }
}