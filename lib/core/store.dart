import 'package:get/get.dart';
import 'package:project_final/models/event_model.dart';
import 'package:project_final/models/user_model.dart';

import 'networking.dart';

class Store extends GetxController {
  List<Event> events = <Event>[].obs;
  List<User> users = <User>[].obs;
  dynamic messages = [].obs;
  dynamic user = {}.obs;
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
    var _res = await api.getLogin(inputEmail, inputPassword);
    if (_res != null) {
      email.value = inputEmail;
      password.value = inputPassword;
      token.value = _res['api_key'];
      user.value = _res['result'];
    } else {
      token.value = '';
    }
  }

  Future<void> getUsers() async {
    var _res = await api.getUsers();
    if (_res != null) {
      users.clear();
      // this doesn't work:
      // res['result'].map((_json) => users.add(User.fromJson(_json)));
      for (final _json in _res['result']) {
        users.add(User.fromJson(_json));
      }
    }
  }

  Future<void> getEvents(id) async {
    var _res = await api.getEvents(id);
    if (_res != null) {
      events.clear();
      for (final _json in _res['result']) {
        events.add(Event.fromJson(_json));
      }
    }
  }
}
