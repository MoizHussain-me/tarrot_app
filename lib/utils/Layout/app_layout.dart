
import 'package:flutter/material.dart';
import 'package:tarrot_app/CometChat/working_screens/previous_messages_list.dart';
import 'package:tarrot_app/utils/Layout/bottom_bar.dart';
import 'package:tarrot_app/utils/Layout/card_list_header.dart';

import '../../Views/Pages/dashboard/dashboard_page.dart';
import '../../Views/Pages/setting/setting.dart';
import '../../Views/Pages/tarrot_readers_list/TarrotCardList.dart';


class MyAppLayout extends StatefulWidget {
  const MyAppLayout({super.key});

  @override
  State<MyAppLayout> createState() => _MyAppLayoutState();
}

class _MyAppLayoutState extends State<MyAppLayout> {
  int _selectedIndex = 1;
  static const List<Widget> _widgetOptions = <Widget>[
    PreviousMessagesList(),
    DashboardPage(),
    settingPage()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80), 
          child: _selectedIndex != 1 ? CardListHeader(title: _selectedIndex==0?'Tarocard list':_selectedIndex==2?'My Profile':''):const Text(''),
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: MyBottomBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ));
  }
}
