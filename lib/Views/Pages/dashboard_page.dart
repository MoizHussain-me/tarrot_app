import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarrot_app/ViewModel/dashboard_viewmodel.dart';
import '../../Model/random_card.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<RandomCard> futureCard;
  bool isDialogEnabled = true;

  @override
  Widget build(BuildContext context) {
    final dashboardViewModel = Provider.of<DashboardViewModel>(context);
    futureCard = dashboardViewModel.fetchCardInfo();
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            futureCard.then((card) {
              debugPrint(card.name);
              _showCardInfo(card);
            });
          },
          child: Text(isDialogEnabled
              ? 'Pull a card of the day '
              : "You Have Already Pulled a card"),
        ),
      ),
    );
  }

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
    setState(() {
      isDialogEnabled = false;
    });

    Timer(const Duration(minutes: 2), () {
      setState(() {
        isDialogEnabled = true;
      });
    });
  }
}
