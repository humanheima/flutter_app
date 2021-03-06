import 'package:flutter/material.dart';
import 'NewRoute.dart';
import 'EchoRoute.dart';
import 'RouterTestRoute.dart';
import 'dart:developer';
import 'package:flutter_app/package_manage.dart';

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
      initialRoute: '/',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      //注册路由表
      routes: {
        "new_page": (context) => NewRoute(),
        "echo_page": (context) => EchoRoute(),
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
              style: Theme.of(context).textTheme.display1,
            ),
            new FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return NewRoute();
                }));
              },
              child: Text('Open new route'),
              textColor: Colors.blue,
            ),
            new FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, "new_page");
              },
              child: Text('使用命名路由打开新的路由界面'),
              textColor: Colors.blue,
            ),
            new FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed("echo_page", arguments: "hi");
              },
              child: Text('使用命名路由打开新的路由界面,并传递参数'),
              textColor: Colors.blue,
            ),
            new FlatButton(
              onPressed: () {
                //debugDumpApp();
                debugger(message: "测试debug");
                print("测试debug");
              },
              child: Text('debugDumpApp'),
              textColor: Colors.blue,
            ),
            RandomWordsWidget(),
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
