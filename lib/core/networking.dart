import 'dart:developer';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

class Networking extends GetConnect {
  String email = '';
  String password = '';

  @override
  void onInit() {
    httpClient.baseUrl = 'http://projectfinal.aenar.biz/api';
    httpClient.addAuthenticator((Request request) async {
      final response = await get('/login?email=$email&password=$password');
      if (response.statusCode == HttpStatus.ok) {
        request.headers['Authorization'] = '${response.body['api_key']}';
      }
      return request;
    });
    httpClient.maxAuthRetries = 3;
  }

  Future<dynamic> getLogin(email, password) async {
    final response = await get('/login?email=$email&password=$password');
    log('res: ${response.body}');
    if (response.statusCode == HttpStatus.ok) {
      email;
      password;
      httpClient.addRequestModifier((Request request) async {
        request.headers['Authorization'] = response.body['api_key'];
        return request;
      });
      return response.body;
    }
    return null;
  }

  Future<dynamic> getUsers() async {
    final response = await get('/users');
    log('res: ${response.body}');
    return (response.statusCode == HttpStatus.ok) ? response.body : null;
  }
}
