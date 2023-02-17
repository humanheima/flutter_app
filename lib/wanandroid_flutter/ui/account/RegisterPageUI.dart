import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_app/wanandroid_flutter/api/CommonService.dart';
import 'package:flutter_app/wanandroid_flutter/model/UserModel.dart';

///
/// Created by dumingwei on 2019/4/18.
/// Desc:
///

class RegisterPageUI extends StatefulWidget {
  @override
  State createState() {
    return RegisterPageUIState();
  }
}

class RegisterPageUIState extends State<RegisterPageUI> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  TextEditingController _pwdAgainController = TextEditingController();

  Future<Null> _register() async {
    String userName = _userNameController.text;
    String password = _pwdController.text;
    String passwordAgain = _pwdAgainController.text;
    if (password != passwordAgain) {
      Fluttertoast.showToast(msg: '两次输入密码不一致');
    } else {
      CommonService().register((UserModel _userModel) {
        if (_userModel != null) {
          if (_userModel.errorCode == 0) {
            Fluttertoast.showToast(msg: "注册成功!");
            Navigator.of(context).pop();
          } else {
            Fluttertoast.showToast(msg: _userModel.errorMsg);
          }
        }
      }, userName, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.4,
        title: Text('注册'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 12),
                alignment: Alignment.centerLeft,
                child: Text(
                  '用户注册后可使用收藏文章等众多功能!',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              TextField(
                autofocus: true,
                maxLines: 1,
                controller: _userNameController,
                decoration: InputDecoration(
                    labelText: '用户名',
                    labelStyle: TextStyle(color: Colors.blue),
                    prefixIcon: Icon(Icons.person)),
              ),
              TextField(
                maxLines: 1,
                controller: _pwdController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: '密码',
                    hintText: '请输入密码',
                    labelStyle: TextStyle(color: Colors.blue),
                    prefixIcon: Icon(Icons.lock)),
              ),
              TextField(
                maxLines: 1,
                controller: _pwdAgainController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: '再次输入密码',
                    hintText: '请再次输入密码',
                    labelStyle: TextStyle(color: Colors.blue),
                    prefixIcon: Icon(Icons.lock)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {
                        _register();
                      },
                      child: Text('注册'),
                    ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
