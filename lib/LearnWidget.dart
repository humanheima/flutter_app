import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/flutter_in_action/main.dart';
import 'package:flutter_app/io_and_network/FileOperationRoute.dart';
import 'package:flutter_app/wanandroid_flutter/GlobalConfig.dart';
import 'package:flutter_app/wanandroid_flutter/wanandroid_flutter_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'io_and_network/HttpTestRoute.dart';
import 'io_and_network/WebSocketRoute.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        ///应用名称
        title: 'Flutter Code Sample for material.AppBar.actions',

        ///主题
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

        ///应用首页路由
        home: new MyHomePage(
          title: "learn widget",
        ));
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new ListView(
          children: <Widget>[
            RaisedButton(
              child: Text(
                "simulate wanandroid_flutter",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                _toWanAndroid(context);
              },
            ),
            RaisedButton(
              child: Text("《Flutter in action 》"),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return FlutterInActionMain();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "文件操作",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new CupertinoPageRoute(builder: (context) {
                  return FileOperationRoute();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "通过HttpClient发起HTTP请求",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new CupertinoPageRoute(builder: (context) {
                  return HttpTestRoute();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "使用WebSockets",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new CupertinoPageRoute(builder: (context) {
                  return WebSocketRoute();
                }));
              },
            ),
          ],
        ),
      ),
    );

    //return Echo(text: "hello world",);
  }

  void _toWanAndroid(BuildContext context) async {
    bool dark = await getThemeStyle();
    Navigator.push(context, new MaterialPageRoute(builder: (context) {
      return new WanAndroidApp(dark);
    }));
  }

  ///返回是否是主题还是
  Future<bool> getThemeStyle() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool darkTheme = sp.getBool("darkTheme");
    if (darkTheme == null) {
      darkTheme = false;
    }
    GlobalConfig.dark = darkTheme;

    return darkTheme;
  }
}
