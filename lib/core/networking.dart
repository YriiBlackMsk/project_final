import 'dart:developer';
import 'package:get/get_connect.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

class Networking extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'http://projectfinal.aenar.biz/api';
  }

  Future<dynamic> getLogin(email, password) async {
    final response = await get('/login?email=$email&password=$password');
    log('res: ${response.body}');
    if (response.statusCode == HttpStatus.ok) {
      return response.body;
    } else {
      return null;
    }
  }
}
