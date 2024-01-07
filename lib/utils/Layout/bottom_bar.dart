import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class MyBottomBar extends StatelessWidget {
  const MyBottomBar(
      {super.key, required this.selectedIndex, required this.onItemTapped});

  final Function(int) onItemTapped;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
        color: Colors.red.shade400,
        buttonBackgroundColor: Colors.amber,
        backgroundColor: Colors.transparent,
        animationDuration: const Duration(milliseconds: 300),
        onTap: onItemTapped,
        index: selectedIndex,
        items: const [
          Icon(
            Icons.search_sharp,
            color: Colors.white,
          ),
          Icon(
            Icons.home,
            color: Colors.white,
          ),
          Icon(
            Icons.settings,
            color: Colors.white,
          ),
        ]);
  }
}
