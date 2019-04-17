import 'package:shared_preferences/shared_preferences.dart';

///
/// Created by dumingwei on 2019/4/13.
/// Desc:
///

class User {
  static final User singleton = User._internal();

  List<String> cookie;
  String userName;

  User._internal();

  factory User() {
    return singleton;
  }

  void clearUserInfo() {
    cookie = null;
    userName = null;
    clearInfo();
  }

  clearInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setStringList("cookies", null);
    sp.setString("username", null);
  }
}
