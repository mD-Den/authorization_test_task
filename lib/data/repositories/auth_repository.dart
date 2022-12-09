import 'dart:convert';

import 'package:authorization_test_task/data/local_data_store/local_data_store.dart';
import 'package:flutter/material.dart';

class AuthRepository {
  final LocalDataStore _store = LocalDataStore();

  Future<bool> login(
      String username, String password, BuildContext context) async {
    bool result = false;
    final String repository = _store.getLoginList();
    final Map<String, dynamic> authRepository = json.decode(repository);
    await Future.delayed(const Duration(seconds: 3), () {
      if (authRepository.containsKey(username) &&
          authRepository[username] == password) {
        result = true;
      } else {
        result = false;
      }
    });
    return result;
  }

  Future<bool> register(
      String username, String password, BuildContext context) async {
    bool result = false;

    final String repository = _store.getLoginList();
    final Map<String, dynamic> authRepository = json.decode(repository);

    await Future.delayed(const Duration(seconds: 3), () {
      if (authRepository.containsKey(username)) {
        result = false;
      } else {
        result = true;
        authRepository.addEntries([MapEntry(username, password)]);
        String newRepo = json.encode(authRepository);
        _store.setLoginList(newRepo);
      }
    });
    return result;
  }
}
