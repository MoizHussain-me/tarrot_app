import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarrot_app/Routes/routes_name.dart';
import 'package:tarrot_app/ViewModel/shared_preferences_viewmodel.dart';
import 'package:tarrot_app/Views/Pages/Registration/registeration_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  Map<String, dynamic>? retrievedUser;
  @override
  void initState() {
    SharedPreferencesHelper.getObject<Map<String, dynamic>>('user')
        .then((value) {
      setState(() {
        retrievedUser = value;
      });
      debugPrint(value.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Container(
          color: Colors.redAccent,
          child: Stack(
            children: [
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(500)),
                    color: Colors.redAccent.shade100),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                      child: Container(
                    height: 200,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(100)),
                        color: Colors.orange.shade400),
                  ))
                ],
              ),
              retrievedUser != null ? Profile(retrievedUser!) : Container(),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 300,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SingleChildScrollView(
                            child: Center(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 50,
                                width: 300,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      'FAQs',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )),
                                    Icon(Icons.arrow_drop_down_sharp)
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 1,
                                color: Colors.black,
                              ),
                              const SizedBox(
                                height: 50,
                                width: 300,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      'Terms And Condition',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )),
                                    Icon(Icons.arrow_drop_down_sharp)
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 1,
                                color: Colors.black,
                              ),
                              const SizedBox(
                                height: 50,
                                width: 300,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      'Feedback and Support',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )),
                                    Icon(Icons.arrow_drop_down_sharp)
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 1,
                                color: Colors.black,
                              ),
                              const SizedBox(
                                height: 50,
                                width: 300,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      'Privacy',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )),
                                    Icon(Icons.arrow_drop_down_sharp)
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 1,
                                color: Colors.black,
                              ),
                              const SizedBox(
                                height: 50,
                                width: 300,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      'About Us',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )),
                                    Icon(Icons.arrow_drop_down_sharp)
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 1,
                                color: Colors.black,
                              ),
                              const SizedBox(
                                height: 50,
                                width: 300,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      'Contact Us',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )),
                                    Icon(Icons.arrow_drop_down_sharp)
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 1,
                                color: Colors.black,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              InkWell(
                                onTap: () {
                                  // Navigator.popAndPushNamed(
                                  //     context, RouteName.login);
                                },
                                child: Container(
                                  height: 50,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Colors.redAccent.withOpacity(0.8),
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        offset: const Offset(
                                            2, 2), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Icon(
                                          Icons.logout_outlined,
                                          size: 30,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () async {
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            await prefs.clear();
                                            Navigator.pushReplacementNamed(
                                                context, RouteName.login);
                                          },
                                          child: const Center(
                                            child: Text(
                                              'Sign Out',
                                              style: TextStyle(
                                                color: Colors.redAccent,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Poppins Medium',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text('Follow Us On'),
                              const SizedBox(
                                height: 10,
                              ),
                              const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height: 30,
                                        child: Image(
                                            image: AssetImage(
                                                'asset/images/fb.png'))),
                                    SizedBox(
                                        height: 30,
                                        child: Image(
                                            image: AssetImage(
                                                'asset/images/insta.png'))),
                                    SizedBox(
                                        height: 30,
                                        child: Image(
                                            image: AssetImage(
                                                'asset/images/twitter.png'))),
                                    SizedBox(
                                        height: 30,
                                        child: Image(
                                            image: AssetImage(
                                                'asset/images/printerest.png')))
                                  ]),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "App Version 7.0",
                                style: TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Profile extends StatelessWidget {
  final Map<String, dynamic> retrievedUser;
  const Profile(this.retrievedUser);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent.shade100,
      child: Stack(children: [
        Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                width: double.infinity,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      const Center(
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage('asset/images/profile.jpg'),
                          radius: 50,
                        ),
                      ),
                      Center(
                        child: Text(
                          retrievedUser["name"].toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.mobile_screen_share_outlined),
                          Text(
                            retrievedUser["metadata"]["PhoneNumber"].toString(),
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => const RegisterUser()));
                            },
                            child: const Center(
                              child: Text(
                                'Edit Profile',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 100,
                          ),
                          InkWell(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => const settingPage()),
                              // );
                            },
                            child: const Center(
                              child: Text(
                                'Setting',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ]),
              ),
            ),
          ],
        ),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Center(child: ProfileImagePicker()),
          ],
        ),
      ]),
    );
  }
}
