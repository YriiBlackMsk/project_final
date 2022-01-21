import 'package:get/get.dart';
import 'package:project_fin/core/networking.dart';

class Store extends GetxController {
  static Store get to => Get.find();
  final email = ''.obs;
  final password = ''.obs;
  final token = ''.obs;
  dynamic user = {}.obs;
  dynamic users = [].obs;

  late final Networking api;

  @override
  void onInit() {
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
}
