import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/wanandroid_flutter/model/UserModel.dart';
import 'package:dio/dio.dart';

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

  void saveUserInfo(UserModel _userModel, Response response) {
    List<String> cookies = response.headers["set-cookie"];
    cookie = cookies;
    userName = _userModel.data.username;
    saveInfo();
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

  void saveInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setStringList("cookies", cookie);
    sp.setString("username", userName);
  }
}
