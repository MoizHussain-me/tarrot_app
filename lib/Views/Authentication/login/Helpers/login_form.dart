import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../utils/BasicComponents/my_button.dart';
import '../../../../utils/BasicComponents/my_text.dart';
import '../../../../utils/BasicComponents/my_text_field.dart';
import '../../../../utils/BasicComponents/number_field_with_c_code.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/my_utils.dart';
import 'package:tarrot_app/utils/country_code_picker.dart' as ccp;
import 'package:tarrot_app/ViewModel/auth_viewmodel.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
//final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(data: AppStrings.welcomeMessage, isHeading: true),
          MyText(data: AppStrings.submitMobileText),
          Utils.myDivider(),
          Center(child: MyText(data: AppStrings.loginOrSignup)),
          Utils.myDivider(),
          const NumberFieldWithCountryCode(),
          Utils.addHorizontalSpace(10.0),
          _buildSendOtpButton(authViewModel, context),
          Utils.myDivider(),
          Center(child: MyText(data: AppStrings.or)),
          Utils.myDivider(),
          _buildContinueWithEmailButton(),
          Utils.addHorizontalSpace(10.0),
          Utils.privacyPolicyText(),
          Utils.addHorizontalSpace(10.0),
        ],
      ),
    );
  }


  Widget _buildSendOtpButton(AuthViewModel authViewModel, BuildContext context) {
    return MyButton(
      data: AppStrings.sendOtp,
      callback: () {
        String phoneNumber = MyTextField.getTextFromTextField();
        String countryCode = ccp.phonecode;
        if (phoneNumber.isEmpty || phoneNumber == "") {
          Utils.flushbarMessage('Please enter phone number', context);
        } else if (countryCode.isEmpty || countryCode == "") {
          Utils.flushbarMessage('Please Select Country Code', context);
        } else if (phoneNumber.startsWith('0')) {
          Utils.flushbarMessage('Please remove zero from start', context);
        } else if (phoneNumber.length != 10) {
          Utils.flushbarMessage('Please enter Correct number', context);
        } else {
          debugPrint('+$countryCode$phoneNumber');
          authViewModel.sendOtp('+$countryCode$phoneNumber', context);
        }
      },
    );
  }

  Widget _buildContinueWithEmailButton() {
    return MyButton(
      data: AppStrings.continueWithEmail,
      icon: Icons.mail,
      isOutlined: true,
      callback: () {},
    );
  }
}
