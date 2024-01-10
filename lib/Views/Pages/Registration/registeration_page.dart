import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tarrot_app/utils/BasicComponents/form_input_field.dart';
import 'package:tarrot_app/utils/BasicComponents/my_text.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Model/user_model.dart';
import '../../../ViewModel/shared_preferences_viewmodel.dart';
import '../../../utils/BasicComponents/my_button.dart';
import '../../../utils/app_strings.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}


class _RegisterUserState extends State<RegisterUser> {
Map<String, dynamic>? retrievedUser;
final fullnamecontroller = TextEditingController();
  
@override
  void initState()  {
    SharedPreferencesHelper.getObject<Map<String, dynamic>>('user').then((value) {
    retrievedUser= value;
    fullnamecontroller.text = retrievedUser!["name"].toString();
    });
    super.initState();
  }

  XFile? pickedFile;
  int selectedOption = 1;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    //double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: MyText(data: AppStrings.registerTitle),
      ),
      body: Stack(
        children: [
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.only(bottomRight: Radius.circular(500)),
                color: Colors.redAccent.shade100),
          ),
          InkWell(
            onTap: () {
              debugPrint("hello");
            },
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: pickedFile != null
                        ? FileImage(File(pickedFile!.path)) as ImageProvider
                        : const AssetImage('asset/images/profile.jpg'),
                  ),
                  Positioned(
                    left: 60,
                    bottom: 0,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.red,
                        ),
                      ),
                      child: IconButton(
                        padding: const EdgeInsets.all(3),
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.red,
                        ),
                        onPressed: () async {
                          debugPrint("hello");
                          final newImage = await ImagePicker().pickImage(
                            source: ImageSource.gallery,
                          );
                          if (newImage != null) {
                            setState(() {
                              pickedFile = newImage;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 200,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      height: 500,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text('Select Your Role*:',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        width: 300,
                                        child: Column(
                                          children: <Widget>[
                                            RadioListTile(
                                              title: const Text(
                                                  "Read Your Fortune"),
                                              value: 1,
                                              groupValue: selectedOption,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedOption = value!;
                                                });
                                              },
                                            ),
                                            RadioListTile(
                                              title: const Text("Be A Reader"),
                                              value: 2,
                                              groupValue: selectedOption,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedOption = value!;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                MyTextField(
                                  label: 'Full Name',
                                  hint: '',
                                  isReadOnly: false,
                                  controller: fullnamecontroller,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter First Name';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: MyButton(
                                    data: 'Save',
                                    callback: () async {
                                      if (_formKey.currentState!.validate()) {
                                        UserModel data = UserModel(
                                            name: fullnamecontroller.text.toString(),
                                            role: selectedOption.toString());
                                        await UserModel.updateUser(retrievedUser!["uid"],data);
                                      } else {
                                        debugPrint("Error");
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
