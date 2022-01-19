import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'login/login_screen.dart';
import 'users_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: SizedBox(
                  child: SvgPicture.asset('assets/images/witch-cat.svg'),
                  width: 160.0,
                ),
              ),
              const Text(
                'Project Final',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              ElevatedButton(
                onPressed: () {
                  // if (_authManager.isAuthenticated.value) {
                  //   Get.to(() => const UsersScreen());
                  // } else {
                     Get.to(() => const LoginScreen());
                  // }
                },
                child: const Icon(Icons.play_arrow),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(const CircleBorder()),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                  backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
