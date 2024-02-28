import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tarrot_app/utils/BasicComponents/form_input_field.dart';
import 'package:tarrot_app/utils/BasicComponents/my_text.dart';
import 'package:image_picker/image_picker.dart';
import '../../../ViewModel/shared_preferences_viewmodel.dart';
import '../../../utils/BasicComponents/my_button.dart';
import '../../../utils/app_strings.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  Map<String, dynamic>? retrievedUser;
  final fullnamecontroller = TextEditingController();
  final languageController = TextEditingController();
  final educationController = TextEditingController();
  final experienceController = TextEditingController();
  final chargesController = TextEditingController();

  XFile? pickedFile;
  int selectedOption = 1;

  String gender = "Male", phone = "", imageUrl = "";

  @override
  void initState() {
    SharedPreferencesHelper.getObject<Map<String, dynamic>>('user')
        .then((value) {
      setState(() {
        retrievedUser = value;
        fullnamecontroller.text = retrievedUser!["name"].toString();
        selectedOption = retrievedUser!["role"].toString() != "default"
            ? int.parse(retrievedUser!["role"].toString())
            : 0;
        phone = retrievedUser!["metadata"]["PhoneNumber"].toString();
        if (selectedOption == 2) {
          chargesController.text =
              retrievedUser!["metadata"]["Charges"].toString();
          languageController.text =
              retrievedUser!["metadata"]["Language"].toString();
          educationController.text =
              retrievedUser!["metadata"]["Education"].toString();
          experienceController.text =
              retrievedUser!["metadata"]["Experience"].toString();
        }
      });
      print(phone);
    });
    super.initState();
  }

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
                                                  debugPrint(selectedOption
                                                      .toString());
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
                                                  debugPrint(selectedOption
                                                      .toString());
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
                                const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Select Your Gender*:',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                    ]),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Radio(
                                      value: 1,
                                      groupValue: 1,
                                      onChanged: (value) {
                                        gender = "Male";
                                      },
                                    ),
                                    const Text('Male'),
                                    Radio(
                                      value: 2,
                                      groupValue: 1,
                                      onChanged: (value) {
                                        gender = "Female";
                                      },
                                    ),
                                    const Text('Female'),
                                  ],
                                ),
                                if (selectedOption == 2)
                                  MyTextField(
                                    label: 'Language',
                                    hint: '',
                                    isReadOnly: false,
                                    controller: languageController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter Language';
                                      }
                                      return null;
                                    },
                                  ),
                                const SizedBox(
                                  height: 20,
                                ),
                                if (selectedOption == 2)
                                  MyTextField(
                                    label: 'Education',
                                    hint: '',
                                    isReadOnly: false,
                                    controller: educationController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter Education';
                                      }
                                      return null;
                                    },
                                  ),
                                const SizedBox(
                                  height: 20,
                                ),
                                if (selectedOption == 2)
                                  MyTextField(
                                    label: 'Experience',
                                    hint: '',
                                    isReadOnly: false,
                                    controller: experienceController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter Experience';
                                      }
                                      return null;
                                    },
                                  ),
                                const SizedBox(
                                  height: 20,
                                ),
                                if (selectedOption == 2)
                                  MyTextField(
                                    label: 'Charges',
                                    hint: '',
                                    isReadOnly: false,
                                    controller: chargesController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter Charges';
                                      }
                                      return null;
                                    },
                                  ),
                                const SizedBox(
                                  height: 20,
                                ),
                                // Center(
                                //   child: MyButton(
                                //     data: 'Save',
                                //     callback: () async {
                                //       String? img = pickedFile?.path ?? '';
                                //       if (_formKey.currentState!.validate() &&
                                //           img != '') {

                                //         imageUrl = await uploadImage(
                                //             File(pickedFile!.path), phone);
                                //         print('Image URL: $imageUrl');

                                //         if (selectedOption == 2) {
                                //           Map<String, dynamic> d = {
                                //             "PhoneNumber": phone.toString(),
                                //             "Gender": gender.toString(),
                                //             "Language": languageController.text,
                                //             "Education":
                                //                 educationController.text,
                                //             "Experience":
                                //                 experienceController.text,
                                //             "Charges": chargesController.text,
                                //           };

                                //       //     UserModel data = UserModel(
                                //       //         name: fullnamecontroller.text
                                //       //             .toString(),
                                //       //         role: selectedOption.toString(),
                                //       //         metadata: d);
                                //       //     await UserModel.updateUser(
                                //       //         retrievedUser!["uid"],
                                //       //         data,
                                //       //         context);
                                //       //   } else {
                                //       //     Map<String, dynamic> d = {
                                //       //       "Gender": gender.toString(),
                                //       //       "PhoneNumber": phone.toString(),
                                //       //     };
                                //       //     UserModel data = UserModel(
                                //       //         name: fullnamecontroller.text
                                //       //             .toString(),
                                //       //         role: selectedOption.toString(),
                                //       //         metadata: d);
                                //       //     await UserModel.updateUser(
                                //       //         retrievedUser!["uid"],
                                //       //         data,
                                //       //         context);
                                //       //   }
                                //       // } else {
                                //       //   debugPrint("Error");
                                //       // }
                                //     },
                                //   ),
                                // ),
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

  Future<String> uploadImage(File imageFile, String imageName) async {
    try {
      Reference storageReference =
          FirebaseStorage.instance.ref().child(imageName);
      UploadTask uploadTask = storageReference.putFile(imageFile);

      await uploadTask.whenComplete(() => null);

      String downloadUrl = await storageReference.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return "";
    }
  }
}
