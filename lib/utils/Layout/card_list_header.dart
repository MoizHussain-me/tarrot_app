// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CardListHeader extends StatelessWidget {
  String title;

  CardListHeader({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return PreferredSize(
      preferredSize: const Size.fromHeight(200),
      child:AppBar(
      backgroundColor: Colors.red,
      automaticallyImplyLeading: false,
      title: SizedBox(
        height: 100,
        width: double.infinity,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (title == "Feedback & Support")
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 28,
                          ),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      const SizedBox(width: 12),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 16, bottom: 20),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage('asset/images/profile.jpg'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: -17,
              left: size.width * 0.82,
              child: Transform.rotate(
                angle: -5.15,
                child: Container(
                  width: size.width * 0.25,
                  height: size.width * 0.18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange.shade300,
                  ),
                ),
              ),
            ),
            Positioned(
              top: -17,
              right: size.width * 0.85,
              child: Transform.rotate(
                angle: -5.15,
                child: Container(
                  width: size.width * 0.25,
                  height: size.width * 0.25,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),);
  }
}
