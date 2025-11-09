import 'dart:core';

import 'package:flutter/material.dart';

///3.7 输入框及表单

class InputRoute extends StatefulWidget {
  @override
  _InputRouteState createState() => new _InputRouteState();
}

class _InputRouteState extends State<InputRoute> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _selectionController = new TextEditingController();

  ///用来控制焦点
  FocusNode focusNode1 = new FocusNode();
  FocusNode focusNode2 = new FocusNode();

  @override
  void initState() {
    super.initState();
    _unameController.addListener(() {
      print(_unameController.text);
    });
    _selectionController.text = "hello world!";
    _selectionController.selection = TextSelection(
        baseOffset: 2, extentOffset: _selectionController.text.length - 1);

    /// 通过FocusNode监听是否获取了焦点
    focusNode1.addListener(() {
      print("focusNode1.hasFocus ? ${focusNode1.hasFocus}");
    });
  }

  @override
  void dispose() {
    _unameController.dispose();
    _selectionController.dispose();
    focusNode1.dispose();
    focusNode2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
            //下划线颜色
            hintColor: Colors.grey[200],
            inputDecorationTheme: InputDecorationTheme(
              //定义label字体样式
              labelStyle: TextStyle(color: Colors.grey),
              //定义提示文本样式
              hintStyle: TextStyle(color: Colors.grey, fontSize: 14.0),
            )),
        child: new Scaffold(
            appBar: new AppBar(
              title: Text("3.7 输入框"),
            ),
            body: new Container(
              child: new ListView(
                children: <Widget>[
                  TextField(
                    controller: _selectionController,
                  ),

                  TextField(
                    autofocus: false,
                    controller: _unameController,
                    decoration: InputDecoration(
                      hintText: "请输入手机号",
                      // 去掉所有边框
                      border: InputBorder.none,
                      // 可选：清除其他状态下的边框（确保无残留）
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),

                  TextField(
                    autofocus: false,
                    controller: _unameController,
                    decoration: InputDecoration(
                        labelText: "用户名",
                        hintText: "用户名或邮箱",
                        prefixIcon: Icon(Icons.person)),
                  ),
                  TextField(
                    onChanged: (value) {
                      //监听文本变化
                      print("password onChanged$value");
                    },
                    decoration: InputDecoration(
                        labelText: "密码",
                        hintText: "您的登陆密码",
                        prefixIcon: Icon(Icons.lock),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepOrange))),
                    obscureText: true,
                  ),
                  Text("下面演示控制焦点"),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          autofocus: false,
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
                                ElevatedButton(
                                  child: Text("移动焦点"),
                                  onPressed: () {
                                    //将焦点从第一个TextField移到第二个TextField
                                    // 直接通过 Builder 的 ctx 获取 FocusScope
                                    FocusScope.of(ctx).requestFocus(focusNode2);
                                  },
                                ),
                                ElevatedButton(
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
                  Text("下面演示去掉输入框的下划线"),
                  Container(
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: '电子邮件地址',
                          prefixIcon: Icon(Icons.email),
                          border: InputBorder.none),
                    ),

                    ///去掉这个注释，可以实现一个高度为1像素的下划线
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Colors.grey.shade200, width: 1.0))),
                  )
                ],
              ),
            )));
  }
}

class FormTestRoute extends StatefulWidget {
  @override
  _FormTestRouteState createState() => new _FormTestRouteState();
}

class _FormTestRouteState extends State<FormTestRoute> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void dispose() {
    _unameController.dispose();
    _pwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("3.7 表单"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Form(
          key: _formKey, //设置globalKey，用于后面获取FormState
          autovalidateMode: AutovalidateMode.always, //开启自动校验
          child: Column(
            children: <Widget>[
              TextFormField(
                  autofocus: false,
                  controller: _unameController,
                  decoration: InputDecoration(
                      labelText: "用户名",
                      hintText: "用户名或邮箱",
                      icon: Icon(Icons.person)),
                  // 校验用户名
                  validator: (v) {
                    return (v != null && v.trim().length > 0) ? null : "用户名不能为空";
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
                    return (v != null && v.trim().length > 5) ? null : "密码不能少于6位";
                  }),
              // 登录按钮
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: ElevatedButton(
                        child: Text("登录"),
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
                    Container(
                      child: Builder(builder: (context) {
                        return ElevatedButton(
                            child: Text('通过Form.of(context)获取FormState'),
                            onPressed: () {
                              if (Form.of(context).validate()) {
                                print("验证通过，可以提交数据");
                              }
                            });
                      }),
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
