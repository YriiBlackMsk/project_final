import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';

import '../../utilities/constants.dart';
import 'login_service.dart';

class LoginScreenModel extends GetxController {
  late final LoginService _loginService;

  @override
  void onInit() {
    super.onInit();
    _loginService = Get.put(LoginService());
  }

  Future<void> loginUser(String email, String password) async {
    final token = await _loginService.getLogin(email, password);

    if (token != null) {
      log('saving token: $token');
      GetStorage().write('token', token);
    } else {
      Get.defaultDialog(
        radius: 0.0,
        title: 'Login failed',
        titlePadding: const EdgeInsets.all(kDefaultPadding),
        contentPadding: const EdgeInsets.all(kDefaultPadding),
        middleText: 'Email or password is incorrect',
        textConfirm: 'OK',
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
        },
      );
    }
  }
}
