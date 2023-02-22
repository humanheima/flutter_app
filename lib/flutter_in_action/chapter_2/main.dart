import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/flutter_in_action/chapter_2/GetStateObjectRoute.dart';
import 'package:flutter_app/flutter_in_action/chapter_2/StateLifecycleTest.dart';
import 'package:flutter_app/flutter_in_action/chapter_2/TipRoute.dart';
import 'package:flutter_app/package_manage.dart';

import 'EchoRoute.dart';
import 'NewRoute.dart';
import 'StateManager.dart';

///
/// Created by dumingwei on 2019-09-12.
/// Desc: 计数器应用示例
///

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/', //名为"/"的路由作为应用的home(首页)
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      //注册路由表
      routes: {
        "new_page": (context) => NewRoute(),
        "echo_page": (context) => EchoRoute(),
        "tip_page": (context) {
          return TipRoute(text: ModalRoute.of(context).settings.arguments);
        },
        "test_state_lifecycle_page": (context) => StateLifecycleTest(),
        "test_get_state_object": (context) => GetStateObjectRoute(),
        '/': (context) => MyHomePage(
              title: 'Flutter Demo Home Page',
            )
      },
      //home: new MyHomePage(title: 'Flutter Demo Home Page'),
      //home: new RouterTestRoute(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _count = 0;

  void _incrementCounter() {
    setState(() {
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('You have pushed the button this many times:'),
            new Text(
              '$_count',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            new ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return NewRoute();
                }));
              },
              child: Text('Open new route'),
            ),
            ElevatedButton(
              onPressed: () async {
                var result = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return TipRoute(text: "我是传递过来的参数");
                }));
                print("路由返回值：$result");
              },
              child: Text('打开新的路由界面,并传递参数并接收返回值'),
            ),
            new ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "tip_page",
                    arguments: "我是命名路由打开的界面传递过来的参数");
              },
              child: Text('使用命名路由打开TipRouter'),
            ),
            new ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "new_page");
              },
              child: Text('使用命名路由打开新的路由界面'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed("echo_page", arguments: "hi,你好");
              },
              child: Text('命名路由传递参数'),
            ),
            new ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed("test_state_lifecycle_page");
              },
              child: Text('测试State生命周期'),
            ),
            new ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed("test_get_state_object");
              },
              child: Text('测试在 widget 树中获取State对象'),
            ),
            new ElevatedButton(
              onPressed: () {
                //debugDumpApp();
                debugger(message: "测试debug");
                debugPrint("测试debug");
              },
              child: Text('测试debug'),
            ),
            RandomWordsWidget(),
            new ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return new StateManage();
                }));
              },
              child: Text('3.2状态管理'),
            ),
            new ElevatedButton(
              onPressed: () async {
                var secret = "arglebargle"; // Or a random generated string.
                var result = runZoned(
                    () async {
                      await Future.delayed(Duration(seconds: 5), () {
                        print("${Zone.current[#_secret]} glop glyf");
                      });
                    },
                    zoneValues: {#_secret: secret},
                    zoneSpecification: ZoneSpecification(
                        print: (Zone self, parent, zone, String value) {
                      if (value.contains(Zone.current[#_secret] as String)) {
                        value = "--censored--";
                      }
                      parent.print(zone, value);
                    }));
                secret = ""; // Erase the evidence.
                await result; // Wait for asynchronous computation to complete.
              },
              child: Text('使用runZoned 捕获异步异常'),
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: "Increment",
        child: new Icon(Icons.add),
      ),
    );
  }
}
