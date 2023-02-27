import 'package:flutter/material.dart';

import 'Code6_2.dart';
import 'Code6_3.dart';
import 'Code6_4.dart';
import 'Code6_5.dart';
import 'Code6_6.dart';
import 'AnimatedListRoute.dart';
import 'TestPageViewRoute.dart';
import 'TestPageViewCacheRoute.dart';
import 'TestTabViewRoute1.dart';

///
/// Created by dumingwei on 2019-10-08.
/// Desc:
///
class Chapter6HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('第6章，可滚动组件'),
        ),
        body: ListView(
          children: <Widget>[
            ElevatedButton(
              child: Text(
                "6.2 SingleChildScrollView",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return SingleChildScrollViewTestRoute();
                }));
              },
            ),
            ElevatedButton(
              child: Text(
                "6.3 ListView",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return ListViewRoute();
                }));
              },
            ),
            ElevatedButton(
              child: Text(
                "6.4 GridView",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return GridViewTestRoute();
                }));
              },
            ),
            ElevatedButton(
              child: Text(
                "6.5 CustomScrollView",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return CustomScrollViewRoute();
                }));
              },
            ),
            ElevatedButton(
              child: Text(
                "6.6 滚动监听及控制",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  //return ScrollControllerTestRoute();
                  return ScrollNotificationTestRoute();
                }));
              },
            ),
            ElevatedButton(
              child: Text(
                "AnimatedList",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return AnimatedListRoute();
                }));
              },
            ),
            ElevatedButton(
              child: Text(
                "PageView与页面缓存",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return TestPageViewRoute();
                }));
              },
            ),
            ElevatedButton(
              child: Text(
                "可滚动组件子项缓存",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return TestPageViewCacheRoute();
                }));
              },
            ),
            ElevatedButton(
              child: Text(
                "测试TabBarView",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return TestTabViewRoute1();
                }));
              },
            ),
          ],
        ));
  }
}
