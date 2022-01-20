import 'dart:developer';
import 'package:get/get.dart';
import 'package:project_fin/core/networking.dart';

class Store extends GetxController {
  static Store get to => Get.find();
  final email = ''.obs;
  final password = ''.obs;
  final token = ''.obs;
  dynamic user = {}.obs;
  final counter = 0.obs;

  late final Networking _api;

  @override
  void onInit() {
    super.onInit();
    _api = Get.put(Networking());
  }

  void increment() {
    counter.value++;
    log('counter: ${counter.value}');
    update();
  }

  Future<void> loginUser(String inputEmail, String inputPassword) async {
    var res = await _api.getLogin(inputEmail, inputPassword);
    if (res != null) {
      email.value = inputEmail;
      password.value = inputPassword;
      token.value = res['api_key'];
      user.value = res['result'];
    } else {
      token.value = '';
    }
  }
}
