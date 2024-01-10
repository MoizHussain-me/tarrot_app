import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarrot_app/utils/my_utils.dart';
import '../../../ViewModel/auth_viewmodel.dart';
import '../../../utils/BasicComponents/my_asset_image.dart';
import '../../../utils/BasicComponents/my_button.dart';
import '../../../utils/BasicComponents/my_text.dart';
import '../../../utils/BasicComponents/sign_in_field.dart';
import '../../../utils/app_strings.dart';
class OtpPage extends StatefulWidget {
  final String verificationId;
  final String phoneNum;

  const OtpPage({
    Key? key,
    required this.verificationId,
    required this.phoneNum,
  }) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  late List<TextEditingController> textControllers;

  @override
  void initState() {
    super.initState();
    textControllers = List.generate(6, (index) => TextEditingController());
  }

  @override
  void dispose() {
    for (var controller in textControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            child: MyAssetImage(data: 'SignIn.png', alignment: Alignment.topCenter),
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Utils.addHorizontalSpace(20),
                      MyText(data: AppStrings.otpVerification, isHeading: true),
                      MyText(data: AppStrings.digitCode),
                      Center(child: MyText(data: "00:56")),
                      Utils.addHorizontalSpace(10),
                      Form(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(6, (index) {
                            return Column(
                              children: [
                                SignInField(pin: index + 1, controller: textControllers[index]),
                                Utils.addVerticalSpace(6),
                              ],
                            );
                          }),
                        ),
                      ),
                      Utils.addHorizontalSpace(20),
                      MyButton(
                        data: AppStrings.verifyOtp,
                        callback: () async {
                          String otp = textControllers.map((controller) => controller.text).join();
                          authViewModel.verifyOtp(widget.verificationId, otp, widget.phoneNum, context);
                        },
                      ),
                      Utils.addHorizontalSpace(20),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: AppStrings.confirmMessge,
                            style: const TextStyle(color: Colors.white),
                            children: <TextSpan>[
                              TextSpan(
                                text: AppStrings.resendMessage,
                                style: TextStyle(color: Colors.orange.shade300),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Utils.addHorizontalSpace(20),
                      MyButton(
                        data: AppStrings.changeNumber,
                        icon: Icons.phone_android_outlined,
                        isOutlined: true,
                        callback: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
