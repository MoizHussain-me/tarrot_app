import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class TarotCardPage extends StatefulWidget {
  @override
  _TarotCardPageState createState() => _TarotCardPageState();
}

class _TarotCardPageState extends State<TarotCardPage> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.reference();
  List<String> _tarotCards = [
    'The Fool',
    'The Magician',
    'The High Priestess',
    // Add the rest of your cards here
  ];
  String _displayedCard = "Shuffle to reveal your card";

@override
void initState() {
  super.initState();
  _dbRef.child('current_tarot_card/card').onValue.listen((event) {
    final Object? card = event.snapshot.value;
    if (card is String) { // Check if the card is a string and handle it safely.
      setState(() {
        _displayedCard = card;
      });
    }
  });
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarot Card Reader'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_displayedCard, style: TextStyle(fontSize: 24)),
            ElevatedButton(
              onPressed: () => _shuffleAndDisplayCard(),
              child: Text('Shuffle Cards'),
            ),
          ],
        ),
      ),
    );
  }

  void _shuffleAndDisplayCard() {
    final random = Random();
    int index = random.nextInt(_tarotCards.length); // to get a random index
    String card = _tarotCards[index];
    setState(() {
      _displayedCard = card;
    });

    // Optionally, update the card in Firebase so both users see the update
    _dbRef.child('current_tarot_card').set({'card': card});
  }
}
