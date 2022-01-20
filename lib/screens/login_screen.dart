import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../core/constants.dart';
import '../core/store.dart';
import 'users_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final Store _store = Get.find<Store>();
  final gs = GetStorage();
  final email = ''.obs;
  final password = ''.obs;
  final TextEditingController emailInputController = TextEditingController();
  final showSpinner = false.obs;

  // @override
  // void initState() {
  //   super.initState();
  //   email = gs.read('email') ?? '';
  //   setState(() => emailInputController.text = gs.read('email') ?? '');
  // }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        body: LoadingOverlay(
          isLoading: showSpinner.value,
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
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
                            email.value = value;
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
                            password.value = value;
                          },
                          decoration: kInputDecoration.copyWith(
                            hintText: 'Enter your password',
                          ),
                        ),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.symmetric(vertical: kDefaultPadding),
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.lightBlueAccent),
                            textStyle: MaterialStateProperty.all<TextStyle>(
                                kButtonTextStyle),
                          ),
                          child: const Text(
                            'Log In',
                            style: kButtonTextStyle,
                          ),
                          onPressed: () async {
                            showSpinner.value = true;
                            try {
                              await _store.loginUser(email.value, password.value);
                              await Future.delayed(const Duration(seconds: 3));
                              if (_store.token.value.isNotEmpty) {
                                gs.write('email', email);
                                Get.to(() => UsersScreen());
                              } else {
                                Get.defaultDialog(
                                  middleText: 'Email or password in incorrect',
                                  textConfirm: 'OK',
                                  confirmTextColor: Colors.white,
                                  onConfirm: () {
                                    Get.back();
                                  },
                                );
                              }
                            } catch (e) {
                              debugPrint('$e');
                            }
                            showSpinner.value = false;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
