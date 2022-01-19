import 'dart:developer';
import 'package:get/get_connect.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

import '../../models/auth_model.dart';

class LoginService extends GetConnect {
  final String loginUrl = 'https://projectfinal.aenar.biz/api/login';

  Future<String?> getLogin(email, password) async {
    final response = await get('$loginUrl?email=$email&password=$password');
    log('res: ${response.body}');
    if (response.statusCode == HttpStatus.ok) {
      var token = response.body['api_key'];
      AuthModel authModel = AuthModel(email, password);
      authModel.setToken(token);
      authModel.fromJson(response.body['result']);
      return token;
    } else {
      return null;
    }
  }
}
