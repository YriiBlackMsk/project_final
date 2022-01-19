import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../utilities/constants.dart';
import 'login_screen_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginScreenModel _viewModel = Get.put(LoginScreenModel());
  final gs = GetStorage();
  String email = '';
  String password = '';
  TextEditingController emailInputController = TextEditingController();
  bool showSpinner = false;

  @override
  void initState() {
    super.initState();
    email = gs.read('email') ?? '';
    setState(() => emailInputController.text = gs.read('email') ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LoadingOverlay(
        isLoading: showSpinner,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    child: SvgPicture.asset('assets/images/witch-cat.svg'),
                    width: 160.0,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: kDefaultPadding * 2),
                  child: TextField(
                    controller: emailInputController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: kInputDecoration.copyWith(
                      hintText: 'Enter your email',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: kDefaultPadding / 2),
                  child: TextField(
                    textAlign: TextAlign.center,
                    obscureText: true,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: kInputDecoration.copyWith(
                      hintText: 'Enter your password',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
                      textStyle:
                      MaterialStateProperty.all<TextStyle>(kButtonTextStyle),
                    ),
                    child: const Text(
                      'Log In',
                      style: kButtonTextStyle,
                    ),
                    onPressed: () async {
                      try {
                        setState(() {
                          showSpinner = true;
                        });
                        await _viewModel.loginUser(email, password);
                        await Future.delayed(const Duration(seconds: 3));
                        // if (user != null) {
                        //   gs.write('email', email);
                        //   Get.off(() => const UsersScreen());
                        // }
                        debugPrint('after login');
                      } catch (e) {
                        debugPrint('$e');
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
