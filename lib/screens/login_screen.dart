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

  final Store store = Get.find<Store>();
  final gs = GetStorage();
  final TextEditingController emailInputController = TextEditingController();
  final showSpinner = false.obs;

  @override
  Widget build(BuildContext context) {
    store.email.value = gs.read('email') ?? '';
    emailInputController.text = store.email.value;
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
                            store.email.value = value;
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
                            store.password.value = value;
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
                              await store.getLogin(store.email.value, store.password.value);
                              await Future.delayed(const Duration(seconds: 1));
                              if (store.token.value.isNotEmpty) {
                                gs.write('email', store.email.value);
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
