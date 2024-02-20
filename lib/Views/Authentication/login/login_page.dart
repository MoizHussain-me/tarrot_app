// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison, prefer_interpolation_to_compose_strings, unused_local_variable
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarrot_app/Views/Authentication/login/Helpers/login_form.dart';
import '../../../ViewModel/auth_viewmodel.dart';
import '../../../utils/BasicComponents/my_asset_image.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            child: MyAssetImage(
                data: 'login_background.png', alignment: Alignment.topCenter),
          ),
          Expanded(
            child: Container(
              height: 400,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Colors.redAccent,
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: LoginForm(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
