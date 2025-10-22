import 'package:flutter/material.dart';
import 'package:flutter_app/flutter_in_action/chapter_6/Code6_10.dart';
import 'package:flutter_app/flutter_in_action/chapter_6/TestNestedScrollView.dart';

import 'Code10_3.dart';
import 'Code6_11_1.dart';
import 'Code6_2.dart';
import 'Code6_3_ListViewTest.dart';
import 'Code6_4.dart';
import 'Code6_10_2.dart';
import 'Code6_6.dart';
import 'AnimatedListRoute.dart';
import 'KeepAliveTest.dart';
import 'TabViewRoute2.dart';
import 'TestPageViewRoute.dart';
import 'TestPageViewCacheRoute.dart';

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
                "测试KeepLiveWrapper控件",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return KeepAliveTest();
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
                  //return TestTabViewRoute1();
                  return TabViewRoute2();
                }));
              },
            ),
            ElevatedButton(
              child: Text(
                "测试 6.10 CustomScrollView 和 Slivers",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return Code610();
                }));
              },
            ),
            ElevatedButton(
              child: Text(
                "6.10.2 Flutter 中常用的 Sliver",
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
                "测试 SliverPersistentHeader",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return PersistentHeaderRoute();
                }));
              },
            ),
            ElevatedButton(
              child: Text(
                "6.11.2 自定义 Sliver",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return SliverPersistentHeaderToBoxRoute();
                }));
              },
            ),
            ElevatedButton(
              child: Text(
                "6.12 NestedScrollView",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  //return SnapAppBar();
                  return NestedTabBarView1();
                }));
              },
            ),
          ],
        ));
  }
}
