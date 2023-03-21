import 'package:flutter/material.dart';
import 'package:flutter_app/flutter_in_action/chapter_7/ValueListenableRoute.dart';

import 'Code7_1.dart';
import 'Code7_2.dart';
import 'Code7_3.dart';
import 'Code7_4.dart';
import 'Code7_5.dart';
import 'Code7_6.dart';

///
/// Created by dumingwei on 2019-10-08.
/// Desc:
///
class Chapter7HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第7章'),
      ),
      body: ListView(
        children: <Widget>[
          ElevatedButton(
            child: Text("7.1 导航返回拦截（WillPopScope）"),
            onPressed: () {
              Navigator.push(context, new MaterialPageRoute(builder: (context) {
                return WillPopScopeRoute();
              }));
            },
          ),
          ElevatedButton(
            child: Text(
              "7.2 数据共享（InheritedWidget）",
              style: new TextStyle(fontSize: 20, color: Colors.redAccent),
            ),
            onPressed: () {
              Navigator.push(context, new MaterialPageRoute(builder: (context) {
                return InheritedWidgetRoute();
              }));
            },
          ),
          ElevatedButton(
            child: Text(
              "7.3 跨组件状态共享（Provider）",
              style: new TextStyle(fontSize: 20, color: Colors.redAccent),
            ),
            onPressed: () {
              Navigator.push(context, new MaterialPageRoute(builder: (context) {
                return ProviderRoute();
              }));
            },
          ),
          ElevatedButton(
            child: Text(
              "7.4 颜色和主题",
              style: new TextStyle(fontSize: 20, color: Colors.redAccent),
            ),
            onPressed: () {
              Navigator.push(context, new MaterialPageRoute(builder: (context) {
                return ThemeTestRoute();
              }));
            },
          ),
          ElevatedButton(
            child: Text(
              "7.5 按需rebuild（ValueListenableBuilder）",
              style: new TextStyle(fontSize: 20, color: Colors.redAccent),
            ),
            onPressed: () {
              Navigator.push(context, new MaterialPageRoute(builder: (context) {
                return ValueListenableRoute();
              }));
            },
          ),
          ElevatedButton(
            child: Text(
              "7.5 异步UI更新（FutureBuilder、StreamBuilder）",
            ),
            onPressed: () {
              Navigator.push(context, new MaterialPageRoute(builder: (context) {
                return Code7_5();
              }));
            },
          ),
          ElevatedButton(
            child: Text(
              "7.6 对话框详解",
            ),
            onPressed: () {
              Navigator.push(context, new MaterialPageRoute(builder: (context) {
                return Code7_6();
              }));
            },
          ),
        ],
      ),
    );
  }
}
