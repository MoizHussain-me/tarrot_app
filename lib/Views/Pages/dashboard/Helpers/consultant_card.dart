import 'package:flutter/material.dart';
import 'package:tarrot_app/Model/random_card.dart';

class ConsultantCard extends StatelessWidget {
  final RandomCard tc;
  const ConsultantCard(this.tc, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: Colors.transparent,
          elevation: 4,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            height: 150,
            width: 150,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(12.0),
              ),
              child: Image.asset(
                'asset/images/${tc.nameShort}.jpg',
                fit: BoxFit.cover,
                height: 150,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          tc.name.toString(),
          style: const TextStyle(
            fontSize: 13,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
