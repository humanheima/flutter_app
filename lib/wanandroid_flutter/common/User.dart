import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/wanandroid_flutter/model/UserModel.dart';
import 'package:dio/dio.dart';

///
/// Created by dumingwei on 2019/4/13.
/// Desc:
///

class User {
  static final User singleton = User._internal();

  // Non-null with safe defaults for null-safety
  List<String> cookie = <String>[];
  String userName = '';

  User._internal();

  factory User() {
    return singleton;
  }

  void saveUserInfo(UserModel _userModel, Response response) async {
    // Headers indexer returns List<String>?; default to empty list
    final List<String>? cookies = response.headers['set-cookie'];
    cookie = cookies ?? <String>[];
    userName = _userModel.data?.username ?? '';
    await saveInfo();
  }

  void clearUserInfo() async {
    cookie = <String>[];
    userName = '';
    await clearInfo();
  }

  Future<void> clearInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.remove('cookies');
    await sp.remove('username');
  }

  Future<void> saveInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setStringList('cookies', cookie);
    await sp.setString('username', userName);
  }
}
