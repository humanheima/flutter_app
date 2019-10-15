import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/flutter_in_action/main.dart';
import 'package:flutter_app/wanandroid_flutter/GlobalConfig.dart';
import 'package:flutter_app/wanandroid_flutter/wanandroid_flutter_main.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'flutter_in_action/chapter_13/Code13_2.dart';
import 'i10n/localization_intl.dart';

void main() {
  runApp(new FlutterInActionApp());
}

class FlutterInActionApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: [
          // 本地化的代理类
          GlobalMaterialLocalizations.delegate,
          //DemoLocalizationsDelegate(),
          IntlDemoLocalizationsDelegate(),
        ],
        supportedLocales: [
          const Locale('en', 'US'), // 美国英语
          const Locale('zh', 'CN'), // 中文简体
          //其它Locales
        ],

        ///应用名称
        title: 'Flutter Code Sample for material.AppBar.actions',

        ///主题
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

        ///应用首页路由
        home: new MyHomePage(
          title: "Flutter in action",
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
        //title: new Text(widget.title),
        //title: Text(DemoLocalizations.of(context).title),
        title: Text(IntlDemoLocalizations.of(context).title),
      ),
      body: new Center(
        child: new ListView(
          children: <Widget>[
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
                "simulate wanandroid_flutter",
              ),
              onPressed: () {
                _toWanAndroid(context);
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
