import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/animations/FadeRouteTest.dart';
import 'package:flutter_app/animations/HeroAnimationRoute.dart';
import 'package:flutter_app/animations/ScaleAnimationRoute.dart';
import 'package:flutter_app/animations/StaggerDemo.dart';
import 'package:flutter_app/customwidgets/CustomPaintRoute.dart';
import 'package:flutter_app/customwidgets/GradientButton.dart';
import 'package:flutter_app/customwidgets/GradientCircularProgressRoute.dart';
import 'package:flutter_app/customwidgets/TurnBoxRoute.dart';
import 'package:flutter_app/eventhandleandnotification/EventBus.dart';
import 'package:flutter_app/eventhandleandnotification/GestureDetectorTestRoute.dart';
import 'package:flutter_app/eventhandleandnotification/NotificationTest.dart';
import 'package:flutter_app/eventhandleandnotification/PointerEventTestRoute.dart';
import 'package:flutter_app/flutter_in_action/main.dart';
import 'package:flutter_app/funtionalwidgets/InheritedWidgets.dart';
import 'package:flutter_app/funtionalwidgets/ThemeTestRoute.dart';
import 'package:flutter_app/funtionalwidgets/WillPopScope.dart';
import 'package:flutter_app/io_and_network/FileOperationRoute.dart';
import 'package:flutter_app/scrollablewidgets/CustomScrollViewtestRoute.dart';
import 'package:flutter_app/scrollablewidgets/GridViewTest.dart';
import 'package:flutter_app/scrollablewidgets/ListViewTest.dart';
import 'package:flutter_app/scrollablewidgets/ScrollControllerTest.dart';
import 'package:flutter_app/scrollablewidgets/SingleChildScrollViewTest.dart';
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
  void initState() {
    super.initState();

    bus.on("login", (arg) {
      print("Receive login event:" + arg);
    });
  }

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
              child: Text(
                "《Flutter in action 》",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return FlutterInActionMain();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "SingleChildScrollView",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  /* return new CounterWidget(
                    initialValue: 0,
                  );*/
                  return SingleChildScrollViewRoute();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "ListView",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  /* return new CounterWidget(
                    initialValue: 0,
                  );*/
                  return ListViewRoute();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "GridView",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  /* return new CounterWidget(
                    initialValue: 0,
                  );*/
                  return GridViewRoute();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "CustomScrollView",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  /* return new CounterWidget(
                    initialValue: 0,
                  );*/
                  return CustomScrollViewRoute();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "ScrollControllerRoute 滚动监听及控制",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  /* return new CounterWidget(
                    initialValue: 0,
                  );*/
                  return ScrollNotificationTestRoute();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "WillPopScopeRoute",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  /* return new CounterWidget(
                    initialValue: 0,
                  );*/
                  return WillPopScopeRoute();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "InheritedWidgetRoute",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  /* return new CounterWidget(
                    initialValue: 0,
                  );*/
                  return InheritedWidgetRoute();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "ThemeTestRoute",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  /* return new CounterWidget(
                    initialValue: 0,
                  );*/
                  return ThemeTestRoute();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "PointerEventTestRoute",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  /* return new CounterWidget(
                    initialValue: 0,
                  );*/
                  return PointerEventTestRoute();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "手势识别GestureDetector",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context, new FadeRoute(builder: (context) {
                  return GestureDetectorTestRoute();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "使用EventBus发送事件",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                bus.emit("login", "Login event");
              },
            ),
            RaisedButton(
              child: Text(
                "send notification",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    //自自定义页面切换动画效果
                    PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 500),
                        pageBuilder: ((BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation) {
                          return new FadeTransition(
                            opacity: animation,
                            child: NotificationRoute(),
                          );
                        })));
              },
            ),
            RaisedButton(
              child: Text(
                "动画基本结构",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new CupertinoPageRoute(builder: (context) {
                  return ScaleAnimationRoute();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "共享元素动画",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new CupertinoPageRoute(builder: (context) {
                  return HeroAnimationRoute();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "交错动画",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new CupertinoPageRoute(builder: (context) {
                  return StaggerDemo();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "自定义组合控件",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new CupertinoPageRoute(builder: (context) {
                  return GradientButtonRoute();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "自定义组合控件实例turnBox",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new CupertinoPageRoute(builder: (context) {
                  return TurnBoxRoute();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "自定义画笔",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new CupertinoPageRoute(builder: (context) {
                  return CustomPaintRoute();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "自定义圆形进度条",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new CupertinoPageRoute(builder: (context) {
                  return GradientCircularProgressRoute();
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
