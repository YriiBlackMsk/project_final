import 'package:get/get.dart';

import 'networking.dart';

class Store extends GetxController {
  dynamic events = [].obs;
  dynamic messages = [].obs;
  dynamic user = {}.obs;
  dynamic users = [].obs;
  final email = ''.obs;
  final password = ''.obs;
  final token = ''.obs;
  late final Networking api;
  static Store get to => Get.find();

  @override
  void onInit() async {
    super.onInit();
    api = Get.put(Networking());
  }

  Future<void> getLogin(String inputEmail, String inputPassword) async {
    var res = await api.getLogin(inputEmail, inputPassword);
    if (res != null) {
      email.value = inputEmail;
      password.value = inputPassword;
      token.value = res['api_key'];
      user.value = res['result'];
    } else {
      token.value = '';
    }
  }

  Future<void> getUsers() async {
    var res = await api.getUsers();
    if (res != null) {
      users.value = res['result'];
    }
  }

  Future<void> getEvents(id) async {
    var res = await api.getEvents(id);
    if (res != null) {
      events.value = res['result'];
    }
  }
}
