import 'dart:convert';

LoginResponseModel loginResponseModel(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  String? username;
  String? password;
  String? token;

  LoginResponseModel({this.username, this.password, this.token});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
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
