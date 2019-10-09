import 'package:flutter/material.dart';

import 'Code3_2.dart';
import 'Code3_3.dart';
import 'Code3_4.dart';
import 'Code3_5.dart';
import 'Code3_6.dart';
import 'Code3_7.dart';
import 'Code3_8.dart';
import 'Echo.dart';

///
/// Created by dumingwei on 2019-09-30.
/// Desc:
///

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Chapter 3',
      initialRoute: '/',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Chapter3HomePage(title: 'Chapter 3 Home Page'),
    );
  }
}

class Chapter3HomePage extends StatefulWidget {
  Chapter3HomePage({Key key, @required this.title}) : super(key: key);

  final String title;

  @override
  _Chapter3HomePageState createState() => new _Chapter3HomePageState();
}

class _Chapter3HomePageState extends State<Chapter3HomePage> {
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
        child: ListView(
          children: <Widget>[
            new Echo(text: "hello world"),
            new RaisedButton(
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return new StateManage();
                }));
              },
              child: Text('3.2状态管理'),
            ),
            new RaisedButton(
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return new TextWidget();
                }));
              },
              child: Text('3.3文本、字体样式'),
            ),
            new RaisedButton(
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return new MyButtonWidget();
                }));
              },
              child: Text('3.4按钮'),
            ),
            RaisedButton(
              child: Text(
                "3.5：图片和Icon",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  /* return new CounterWidget(
                    initialValue: 0,
                  );*/
                  return MyImageWidget();
                }));
              },
            ),
            RaisedButton(
              child: Text('3.6 单选开关和复选框'),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return SwitchAndCheckBox();
                }));
              },
            ),
            RaisedButton(
                child: Text('3.7 输入框及表单'),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) {
                    //return new InputRoute();
                    return new FormTestRoute();
                  }));
                }),
            RaisedButton(
                child: Text('3.8 进度指示器'),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) {
                    //return new InputRoute();
                    return new ProgressWidget();
                  }));
                }),
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
