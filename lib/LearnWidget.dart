import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/animations/FadeRouteTest.dart';
import 'package:flutter_app/animations/HeroAnimationRoute.dart';
import 'package:flutter_app/animations/ScaleAnimationRoute.dart';
import 'package:flutter_app/animations/StaggerDemo.dart';
import 'package:flutter_app/animations/animation_main_page.dart';
import 'package:flutter_app/customwidgets/CustomPaintRoute.dart';
import 'package:flutter_app/customwidgets/GradientButton.dart';
import 'package:flutter_app/customwidgets/GradientCircularProgressRoute.dart';
import 'package:flutter_app/customwidgets/TurnBoxRoute.dart';
import 'package:flutter_app/eventhandleandnotification/EventBus.dart';
import 'package:flutter_app/eventhandleandnotification/GestureDetectorTestRoute.dart';
import 'package:flutter_app/eventhandleandnotification/NotificationTest.dart';
import 'package:flutter_app/eventhandleandnotification/PointerEventTestRoute.dart';
import 'package:flutter_app/figma/my_works_page.dart';
import 'package:flutter_app/staggered/staggered_index.dart';
import 'package:flutter_app/flutter_in_action/main.dart';
import 'package:flutter_app/login_demo_main.dart';
import 'package:flutter_app/proxy/dio_proxy_demo.dart';
import 'package:flutter_app/wanandroid_flutter/GlobalConfig.dart';
import 'package:flutter_app/wanandroid_flutter/wanandroid_flutter_main.dart';
import 'package:flutter_app/widget/GrowingTextDemo.dart';
import 'package:flutter_app/widget/AIChatDemo.dart';
import 'package:flutter_app/widget/FutureBuilderDemo.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/return_value_demo.dart';
import 'package:flutter_app/tabbardemo/tabbar_demo.dart';
import 'package:flutter_app/popup_menu_demo.dart';

import 'flutter_in_action/chapter11/HttpTestRoute.dart';
import 'flutter_in_action/chapter11/WebSocketRoute.dart';

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

  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 创建一个 MethodChannel 实例
  static const platform = const MethodChannel('com.example/my_channel');

  // scale factor for the second native-button animation
  double _nativeButtonScale = 1.0;
  String nativeButtonText = "打开原生界面2";

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
            ElevatedButton(
              child: Text(
                "测试代理功能",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                _startProxyDemo();
              },
            ),
            ElevatedButton(
              child: Text(
                "我的作品页面",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                _openMyWorksPage();
              },
            ),
            ElevatedButton(
              child: Text(
                "Staggered demo 演示",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                _flutterStaggeredGridViewDemoPage();
              },
            ),

            ElevatedButton(
              child: Text(
                "打开原生界面",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                _openNativeScreen();
              },
            ),

            ElevatedButton(
              child: Text(
                "动画Text",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return GrowingTextDemo();
                }));
              },
            ),
            ElevatedButton(
              child: Text(
                "AI聊天演示 🤖",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return AIChatDemo();
                }));
              },
            ),
            ElevatedButton(
              child: Text(
                "FutureBuilder 示例",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return FutureBuilderDemo();
                }));
              },
            ),
            ElevatedButton(
              child: Text(
                "打开Figma演示页面入口",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return LoginDemoHome();
                }));
              },
            ),

            ElevatedButton(
              child: Text(
                "返回值 Demo",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  // 跳转到我们之前创建的 HomePage（不使用新的 MaterialApp）
                  return HomePage();
                }));
              },
            ),

            ElevatedButton(
              child: Text(
                "TabBar 使用示例",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return TabBarDemoHome();
                }));
              },
            ),

            ElevatedButton(
              child: Text(
                "PopupMenu 使用示例",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return PopupMenuDemoPage();
                }));
              },
            ),

            // Replaced the empty second button with a scaled animation + MethodChannel call
            Transform.scale(
              scale: _nativeButtonScale,
              child: ElevatedButton(
                child: Text(
                  nativeButtonText,
                  style: new TextStyle(fontSize: 20, color: Colors.redAccent),
                ),
                onPressed: () async {
                  // brief scale-up animation to give a 'zoom' effect
                  setState(() {
                    _nativeButtonScale = 1.1;
                  });
                  await Future.delayed(Duration(milliseconds: 120));
                  if (!mounted) return;
                  setState(() {
                    _nativeButtonScale = 1.0;
                  });

                  // Call Android FlutterPlugin via MethodChannel to show a native dialog
                  try {
                    final result =
                        await platform.invokeMethod('openNativeDialog');
                    setState(() {
                      nativeButtonText = "原生返回的 result: $result";
                    });
                    print(result);
                  } on PlatformException catch (e) {
                    print("Failed to open native dialog: '${e.message}'.");
                  }
                },
              ),
            ),
            ElevatedButton(
              child: Text(
                "simulate wanandroid_flutter",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                _toWanAndroid(context);
              },
            ),
            ElevatedButton(
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
            ElevatedButton(
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
            ElevatedButton(
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
            ElevatedButton(
              child: Text(
                "使用EventBus发送事件",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                bus.emit("login", "Login event");
              },
            ),
            ElevatedButton(
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

            ElevatedButton(
              onPressed: () {
                // 在需要的地方导航到动画主页
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnimationMainPage()),
                );
              },
              child: Text(
                "动画演示入口",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
            ),

            ElevatedButton(
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
            ElevatedButton(
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
            ElevatedButton(
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
            ElevatedButton(
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
            ElevatedButton(
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
            ElevatedButton(
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
            ElevatedButton(
              child: Text(
                "自定义圆形进度条",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new CupertinoPageRoute(builder: (context) {
                  return GradientCircularProgressRoute(
                    radius: 10,
                    colors: [Colors.redAccent, Colors.redAccent],
                  );
                }));
              },
            ),
            ElevatedButton(
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
            ElevatedButton(
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
    bool darkTheme = sp.getBool("darkTheme") ?? false;
    GlobalConfig.dark = darkTheme;

    return darkTheme;
  }

  _startProxyDemo() {
    Navigator.push(context, new MaterialPageRoute(builder: (context) {
      return new DioProxyDemo();
    }));
  }

  _openMyWorksPage() {
    Navigator.push(context, new MaterialPageRoute(builder: (context) {
      return const MyWorksPage();
    }));
  }

  _flutterStaggeredGridViewDemoPage() {
    Navigator.push(context, new MaterialPageRoute(builder: (context) {
      return const StaggeredDemosIndex();
    }));
  }

  // 定义一个方法来调用原生代码
  _openNativeScreen() async {
    try {
      final result = await platform.invokeMethod('openNativeScreen');
      print(result);
    } on PlatformException catch (e) {
      print("Failed to open native screen: '${e.message}'.");
    }
  }
}
