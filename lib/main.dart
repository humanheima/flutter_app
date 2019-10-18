import 'package:flutter/material.dart';
import 'package:flutter_app/wanandroid_flutter/GlobalConfig.dart';
import 'package:flutter_app/wanandroid_flutter/wanandroid_flutter_main.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'enjoy_android/enjoy_android_main.dart';
import 'flutter_in_action/main.dart';
import 'i10n/localization_intl.dart';
import 'pubs/dio_test/DioTest.dart';

/// 程序入口

void main() => runApp(AppWidget());

class AppWidget extends StatelessWidget {
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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        IntlDemoLocalizationsDelegate(),
      ],

      supportedLocales: [
        const Locale('en', 'US'), // 美国英语
        const Locale('zh', 'CN'), // 中文简体
        //其它Locales
      ],

      ///应用首页路由
      home: AppHomePage(
        title: "Flutter Demo Home Page",
      ),
    );
  }
}

class AppHomePage extends StatefulWidget {
  final String title;

  AppHomePage({Key key, this.title}) : super(key: key);

  @override
  _AppHomePageState createState() => new _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(IntlDemoLocalizations.of(context).title),
      ),
      body: new ListView(
        children: <Widget>[
          RaisedButton(
            child: Text("dio"),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DioTest();
              }));
            },
          ),
          RaisedButton(
            child: Text("《Flutter实战》"),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FlutterInActionMain();
              }));
            },
          ),
          RaisedButton(
            child: Text('enjoy android'),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return EnjoyAndroidMain();
              }));
            },
          ),
          RaisedButton(
            child: Text('玩安卓'),
            onPressed: () {
              _toWanAndroid(context);
            },
          ),
        ],
      ),
    );
  }

  void _toWanAndroid(BuildContext context) async {
    bool darkTheme = await getThemeStyle();
    Navigator.push(context, new MaterialPageRoute(builder: (context) {
      return new WanAndroidApp(darkTheme);
    }));
  }

  ///返回是否是暗色主题
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
