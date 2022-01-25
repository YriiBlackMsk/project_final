import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

class Networking extends GetConnect {
  String email = '';
  String password = '';

  @override
  void onInit() {
    httpClient.baseUrl = dotenv.env['BASE_URL'];
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
    log('/login?email=$email&password=$password: ${response.body}');
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
    log('/users: ${response.body}');
    return (response.statusCode == HttpStatus.ok) ? response.body : null;
  }

  Future<dynamic> getEvents(id) async {
    final response = await get('/events?page=1&size=20&userId=$id');
    log('/events?page=1&size=20&userId=$id: ${response.body}');
    return (response.statusCode == HttpStatus.ok) ? response.body : null;
  }
}
