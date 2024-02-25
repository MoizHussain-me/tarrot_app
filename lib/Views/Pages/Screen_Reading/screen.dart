import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class ScreenSharing extends StatefulWidget {
  const ScreenSharing({Key? key}) : super(key: key);

  @override
  State<ScreenSharing> createState() => _ScreenSharingState();
}

class _ScreenSharingState extends State<ScreenSharing> {
  final _database = FirebaseDatabase.instance.ref();
  String _displayText = "Initial Text";

  @override
  void initState() {
    super.initState();
    _activateListeners();
  }

  void _activateListeners() {
    _database.child('sharedText').onValue.listen((event) {
      final String text = event.snapshot.value.toString();
      setState(() {
        _displayText = text;
      });
    });
  }

  void _updateText() {
    _database.child('sharedText').set('New Text ${DateTime.now()}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen Sharing with Firebase'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_displayText, style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateText,
              child: Text('Update Text'),
            ),
          ],
        ),
      ),
    );
  }
}
