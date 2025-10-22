import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/wanandroid_flutter/api/CommonService.dart';
import 'package:flutter_app/wanandroid_flutter/common/User.dart';
import 'package:flutter_app/wanandroid_flutter/common/application.dart';
import 'package:flutter_app/wanandroid_flutter/event/login_event.dart';
import 'package:flutter_app/wanandroid_flutter/model/UserModel.dart';
import 'package:flutter_app/wanandroid_flutter/ui/account/RegisterPageUI.dart';
import 'package:fluttertoast/fluttertoast.dart';

///
/// Created by dumingwei on 2019/4/18.
/// Desc:
///

class LoginPageUI extends StatefulWidget {
  @override
  State createState() {
    return LoginPageUIState();
  }
}

class LoginPageUIState extends State<LoginPageUI> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _psdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.4,
        title: Text('登录'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  '请使用wanandroid账号登录',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              TextField(
                autofocus: true,
                controller: _userNameController,
                decoration: InputDecoration(
                    labelText: '用户名',
                    hintText: '请输入用户名或邮箱',
                    labelStyle: TextStyle(color: Colors.blue),
                    prefixIcon: Icon(Icons.person)),
              ),
              TextField(
                autofocus: true,
                controller: _psdController,
                obscureText: true,
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: '密码',
                  hintText: '您的登录密码',
                  labelStyle: TextStyle(color: Colors.blue),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 28),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: ElevatedButton(
                            child: Text('登录'),
                            onPressed: () {
                              _login();
                            }))
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      onRegisterClick();
                    },
                    child: Text(
                      '还没有账号，注册一个？',
                      style: TextStyle(fontSize: 14),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onRegisterClick() async {
    await Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return RegisterPageUI();
    }));
  }

  void _login() async {
    String username = _userNameController.text;
    String password = _psdController.text;
    CommonService().login((UserModel _userModel, Response response) {
      if (_userModel.errorCode == 0) {
        User().saveUserInfo(_userModel, response);
        Application.eventBus.fire(LoginEvent());
        Fluttertoast.showToast(msg: "登录成功！");
        Navigator.of(context).pop();
      } else {
        Fluttertoast.showToast(msg: _userModel.errorMsg);
      }
        }, username, password);
  }
}
