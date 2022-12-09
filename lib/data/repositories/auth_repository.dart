import 'dart:convert';

import 'package:authorization_test_task/data/local_data_store/local_data_store.dart';
import 'package:flutter/material.dart';

import '../../ui/pages/login_page.dart';
import '../../ui/pages/picture_page.dart';

class AuthRepository {
  final LocalDataStore _store = LocalDataStore();

  Future<void> login(
      String username, String password, BuildContext context) async {
    final String repository = _store.getLoginList();
    final Map<String, dynamic> authRepository = json.decode(repository);
    await Future.delayed(const Duration(seconds: 3), () {
      if (authRepository.containsKey(username) &&
          authRepository[username] == password) {
        _showSnackBar(context, 'Successful entry!', true);
      } else {
        _showSnackBar(context, 'Something went wrong.', false);
      }
    });
  }

  Future<void> register(
      String username, String password, BuildContext context) async {
    final String repository = _store.getLoginList();
    final Map<String, dynamic> authRepository = json.decode(repository);

    await Future.delayed(const Duration(seconds: 3), () {
      if (authRepository.containsKey(username)) {
        _showSnackBar(context, 'This login is already registered', null);
      } else {
        authRepository.addEntries([MapEntry(username, password)]);
        _showSnackBar(
            context, 'Register Successful! Pls login to the account', null);

        String newRepo = json.encode(authRepository);
        _store.setLoginList(newRepo);
      }
    });
  }

  void _showSnackBar(
      BuildContext context, String message, bool? isSuccessfulEntry) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    if (isSuccessfulEntry == null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              PicturePage(isSuccessfulEntry: isSuccessfulEntry)));
    }
  }
}
