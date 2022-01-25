import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/splash_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.tealAccent,
            ),
            child: Text('Project Final'),
          ),
          ListTile(
            title: const Text('Users'),
            onTap: () {
              Get.toNamed('/users/');
            },
          ),
          const Divider(
            key: Key('-'),
          ),
          ListTile(
            title: const Text('Exit'),
            onTap: () {
              Get.offAll(SplashScreen());
            },
          ),
        ],
      ),
    );
  }
}
