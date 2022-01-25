import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/events_screen.dart';
import '../screens/users_screen.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = 0;
      Get.back();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.group),
          label: 'Users',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Todos',
        ),
      ],
      selectedItemColor: Colors.blueAccent,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}
