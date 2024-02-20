import 'dart:async';
import 'package:cometchat_sdk/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarrot_app/ViewModel/dashboard_viewmodel.dart';
import 'package:tarrot_app/ViewModel/shared_preferences_viewmodel.dart';
import 'package:tarrot_app/Views/Pages/Dashboard/Helpers/consultant_card.dart';
import 'package:tarrot_app/Views/Pages/Dashboard/Helpers/daily_tarot_cart.dart';
import 'package:tarrot_app/Views/Pages/Dashboard/Helpers/tarot_recommended_card.dart';
import '../../../Model/random_card.dart';
import '../tarrot_readers_list/tarrot_card_list.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<RandomCard> todayCard;
  late Future<List<RandomCard>> dailyTarot;
  late Future<List<RandomCard>> experiencedTarot;
  bool isDialogEnabled = true;
  Map<String, dynamic>? retrievedUser;
  @override
  void initState() {
    SharedPreferencesHelper.getObject<Map<String, dynamic>>('user').then((value) {
    setState(() {
    retrievedUser = value;
    });
    debugPrint(value.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardViewModel = Provider.of<DashboardViewModel>(context);
    dailyTarot = dashboardViewModel.fetchCards(numberOfCards: 5);
    experiencedTarot = dashboardViewModel.fetchCards(numberOfCards: 5);
    todayCard = dashboardViewModel.fetchSingleCard();
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          // height: size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                //Release pai yahan stack daldena sahi ho jaye ga 
                Positioned(
                  top: -50,
                  left: -90,
                  child: Container(
                    width: 280,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red.shade400,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(35),
                      margin: const EdgeInsets.only(top: 50),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 65,
                              ),
                              retrievedUser != null
                                  ? Text(
                                      'Hello ${retrievedUser!["name"].toString()}',
                                      style: const TextStyle(
                                          color: Colors.white),
                                    )
                                  : const Text(
                                      'Hello user',
                                      style: TextStyle(color: Colors.white),
                                    ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 65,
                                height: 2,
                              ),
                              RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Welcome To',
                                      style: TextStyle(
                                        fontSize: 22,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '\nTarrot App',
                                      style: TextStyle(
                                        fontSize: 22,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 45,
                  right: 20,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_none),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 200,
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(top: 250),
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          //Daily tarrot Start
                          const Row(
                            children: [
                              Text(
                                'Daily Taro',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          const Row(
                            children: [
                              Text(
                                'The stars are on your favour, you can\'t be horrible.\nThey won\'t let you down',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 150,
                            width: size.width,
                            child: FutureBuilder<List<RandomCard>>(
                              future: dailyTarot,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return const Text('No cards found');
                                } else {
                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      RandomCard category =
                                          snapshot.data![index];
                                      return InkWell(
                                          onTap: () {
                                            debugPrint(
                                                category.name.toString());
                                            _showCardInfo(category);
                                          },
                                          child: DailyTarot(category));
                                    },
                                  );
                                }
                              },
                            ),
                          ),    
                          //Daily tarrot End
                          const SizedBox(
                            height: 15,
                          ),
                          //services Section Start        
                          Container(
                            height: 115,
                            color: Colors.red.shade200,
                            padding: const EdgeInsets.all(10),
                            width: size.width,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Card(
                                  margin: const EdgeInsets.only(left: 20),
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: SizedBox(
                                    height: 60,
                                    width: 300,
                                    child: Center(
                                      child: InkWell(
                                        onTap: () {
                                          todayCard.then((card) {
                                            debugPrint(card.name);
                                            _showCardInfo(card);
                                          });
                                        },
                                        child: const Text(
                                          '\t\t\t\t\tPull a card of a day ',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),
                              ],
                            ),
                          ),        
                          //services Section End
                          const SizedBox(
                            height: 15,
                          ),
                          //Recommended Tarots Cards Start
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Recommended Tarot Card Reader\'s',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) =>
                                              const TarrotCardList()));
                                },
                                child: const Row(
                                  children: [
                                    Text(
                                      'See all',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.blue,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 200,
                            width: size.width,
                            child: FutureBuilder<List<User>>(
                              future: dashboardViewModel.getAllReaders(5),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return const Center(
                                      child: Text('Error fetching data'));
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return const Center(
                                      child: Text('No categories found'));
                                } else {
                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      User reader = snapshot.data![index];
                                      return TarrotRecommendCard(reader);
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                  
                          // Recommended Tarots Cards end
                  
                          const SizedBox(
                            height: 15,
                          ),
                  
                          Container(
                            height: 210.0,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.red.shade300,
                                  Colors.red.shade800,
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        top: 20, left: 10),
                                    color: Colors.transparent,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Trending Consultations',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        const Text(
                                          'Astrology is a language, if you want to understand this language, speak to us!',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 18,
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: const Text(
                                            'Swipe',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 200,
                                    width: size.width,
                                    child: FutureBuilder<List<RandomCard>>(
                                      future: experiencedTarot,
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const CircularProgressIndicator();
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        } else if (!snapshot.hasData ||
                                            snapshot.data!.isEmpty) {
                                          return const Text('No cards found');
                                        } else {
                                          return ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: snapshot.data!.length,
                                            itemBuilder: (context, index) {
                                              RandomCard category =
                                                  snapshot.data![index];
                                              return InkWell(
                                                  onTap: () {
                                                    debugPrint(category.name
                                                        .toString());
                                                    _showCardInfo(category);
                                                  },
                                                  child: ConsultantCard(
                                                      category));
                                            },
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


              // Padding(
              //   padding: const EdgeInsets.only(top: 150),
              //   child: Container(
              //     // padding: EdgeInsets.all(10),
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     child: Column(
              //       children: [
              //         SizedBox(
              //           height: 250,
              //         ),
              //         Column(
              //           children: [
              //             Stack(
              //               children: [],
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // ),




  void _showCardInfo(RandomCard card) {
    if (!isDialogEnabled) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(card.name.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Image.asset('asset/images/${card.nameShort}.jpg'),
                Text.rich(
                  TextSpan(
                    text: '\nMeaning Up: \n', // The base text
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: card.meaningUp.toString(),
                        // The base text
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: '\nMeaning Reverse: \n', // The base text
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: card.meaningRev.toString(),
                        // The base text
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: '\nDescription: \n', // The base text
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: card.desc.toString(),
                        // The base text
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                Text('Meaning Reverse: ${card.meaningRev}'),
                Text('Description: ${card.desc}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    // setState(() {
    //   isDialogEnabled = false;
    // });

    Timer(const Duration(minutes: 2), () {
      setState(() {
        isDialogEnabled = true;
      });
    });
  }
}
