import 'package:flutter/material.dart';
import '../../../../Model/random_card.dart';

class DailyTarot extends StatelessWidget {
  final RandomCard tc;

  const DailyTarot(this.tc, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          SizedBox(
            width: 110,
            height: 100,
            child: 
                Image.asset('asset/images/${tc.nameShort}.jpg',
              fit: BoxFit.cover, 
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              tc.name.toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
