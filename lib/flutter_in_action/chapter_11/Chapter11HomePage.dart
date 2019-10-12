import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Code11_1.dart';
import 'Code11_2.dart';
import 'Code11_3.dart';
import 'Code11_5.dart';
import 'Code11_7.dart';

///
/// Created by dumingwei on 2019-10-11.
/// Desc:
///
class Chapter11HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('文件操作与网络请求'),
      ),
      body: ListView(
        children: <Widget>[
          RaisedButton(
            child: Text("11.1 文件操作"),
            onPressed: () {
              Navigator.push(context,
                  new CupertinoPageRoute(builder: (context) {
                return FileOperationRoute();
              }));
            },
          ),
          RaisedButton(
            child: Text("11.2 通过HttpClient发起HTTP请求"),
            onPressed: () {
              Navigator.push(context,
                  new CupertinoPageRoute(builder: (context) {
                return HttpTestRoute();
              }));
            },
          ),
          RaisedButton(
            child: Text("11.3 Http请求-Dio http库"),
            onPressed: () {
              Navigator.push(context,
                  new CupertinoPageRoute(builder: (context) {
                return DioTest();
              }));
            },
          ),
          RaisedButton(
            child: Text("11.5：使用WebSocketRoute"),
            onPressed: () {
              Navigator.push(context,
                  new CupertinoPageRoute(builder: (context) {
                return WebSocketRoute();
              }));
            },
          ),
          RaisedButton(
            child: Text("11.7 Json转Dart Model类"),
            onPressed: () {
              Navigator.push(context,
                  new CupertinoPageRoute(builder: (context) {
                return Code11_7();
              }));
            },
          ),
        ],
      ),
    );
  }
}
