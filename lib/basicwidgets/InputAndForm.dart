import 'dart:core';

import 'package:flutter/material.dart';

///输入框和表单

class InputAndFormRoute extends StatefulWidget {
  @override
  _InputAndFormRouteState createState() => new _InputAndFormRouteState();
}

class _InputAndFormRouteState extends State<InputAndFormRoute> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _selectionController = new TextEditingController();

  FocusNode focusNode1 = new FocusNode();
  FocusNode focusNode2 = new FocusNode();
  FocusScopeNode focusScopeNode;

  @override
  void initState() {
    super.initState();
    _unameController.addListener(() {
      print(_unameController.text);
    });
    _selectionController.text = "hello world!";
    _selectionController.selection = TextSelection(
        baseOffset: 2, extentOffset: _selectionController.text.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: Text("按钮"),
        ),
        body: new Container(
          child: new ListView(
            children: <Widget>[
              TextField(
                controller: _selectionController,
              ),
              TextField(
                autofocus: true,
                onChanged: (value) {
                  //监听文本变化
                  print("onChanged$value");
                },
                decoration: InputDecoration(
                    labelText: "用户名",
                    hintText: "用户名或邮箱",
                    prefixIcon: Icon(Icons.person)),
              ),
              TextField(
                controller: _unameController,
                decoration: InputDecoration(
                    labelText: "密码",
                    hintText: "您的登陆密码",
                    prefixIcon: Icon(Icons.lock)),
                obscureText: true,
              ),
              Text("下面显示焦点控制"),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      autofocus: true,
                      focusNode: focusNode1, //关联focusNode1
                      decoration: InputDecoration(labelText: "input1"),
                    ),
                    TextField(
                      focusNode: focusNode2, //关联focusNode2
                      decoration: InputDecoration(labelText: "input2"),
                    ),
                    Builder(
                      builder: (ctx) {
                        return Column(
                          children: <Widget>[
                            RaisedButton(
                              child: Text("移动焦点"),
                              onPressed: () {
                                //将焦点从第一个TextField移到第二个TextField
                                // 这是一种写法 FocusScope.of(context).requestFocus(focusNode2);
                                // 这是第二种写法
                                if (null == focusScopeNode) {
                                  focusScopeNode = FocusScope.of(context);
                                }
                                focusScopeNode.requestFocus(focusNode2);
                              },
                            ),
                            RaisedButton(
                              child: Text("隐藏键盘"),
                              onPressed: () {
                                // 当所有编辑框都失去焦点时键盘就会收起
                                focusNode1.unfocus();
                                focusNode2.unfocus();
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              Text("表单Form"),
            ],
          ),
        ));
  }
}

class FormTestRoute extends StatefulWidget {
  @override
  _FormTestRouteState createState() => new _FormTestRouteState();
}

class _FormTestRouteState extends State<FormTestRoute> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("按钮"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Form(
          key: _formKey, //设置globalKey，用于后面获取FormState
          autovalidate: true, //开启自动校验
          child: Column(
            children: <Widget>[
              TextFormField(
                  autofocus: true,
                  controller: _unameController,
                  decoration: InputDecoration(
                      labelText: "用户名",
                      hintText: "用户名或邮箱",
                      icon: Icon(Icons.person)),
                  // 校验用户名
                  validator: (v) {
                    return v.trim().length > 0 ? null : "用户名不能为空";
                  }),
              TextFormField(
                  controller: _pwdController,
                  decoration: InputDecoration(
                      labelText: "密码",
                      hintText: "您的登录密码",
                      icon: Icon(Icons.lock)),
                  obscureText: true,
                  //校验密码
                  validator: (v) {
                    return v.trim().length > 5 ? null : "密码不能少于6位";
                  }),
              // 登录按钮
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        padding: EdgeInsets.all(15.0),
                        child: Text("登录"),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: () {
                          //在这里不能通过此方式获取FormState，context不对
                          //print(Form.of(context));

                          // 通过_formKey.currentState 获取FormState后，
                          // 调用validate()方法校验用户名密码是否合法，校验
                          // 通过后再提交数据。
                          if ((_formKey.currentState as FormState).validate()) {
                            //验证通过提交数据
                          }
                        },
                      ),
                    ),
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
