import 'package:shared_preferences/shared_preferences.dart';

class LocalDataStore {
  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ?? await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  static Future<SharedPreferences?> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  final String _kLoginList = 'LOGIN_LIST';

  void setLoginList(String login) {
    _prefsInstance?.setString(_kLoginList, login);
  }

  String getLoginList() {
    return _prefsInstance?.getString(_kLoginList) ??
        '''{
    "username": "password"
    }''';
  }
}
