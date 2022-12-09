import 'dart:convert';

RegisterResponseModel registerResponseModel(String str) =>
    RegisterResponseModel.fromJson(json.decode(str));

class RegisterResponseModel {
  String? username;
  String? password;
  String? token;

  RegisterResponseModel({this.username, this.password, this.token});

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['token'] = token;
    return data;
  }
}
