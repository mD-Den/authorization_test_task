import 'dart:convert';

import 'package:authorization_test_task/data/constants/constants.dart';
import 'package:authorization_test_task/data/models/login_request_model.dart';
import 'package:authorization_test_task/data/models/register_response_model.dart';
import 'package:http/http.dart' as http;

import '../data/models/register_request_model.dart';

class APIService {
  static Map<String, String> requestHeaders = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  static Future<bool> login(LoginRequestModel model) async {
    var url = Uri.parse(loginAPI);

    var response = await http.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<RegisterResponseModel> register(
      RegisterRequestModel model) async {
    var url = Uri.parse(registerAPI);

    var response = await http.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));

    return registerResponseModel(response.body);
  }
}
