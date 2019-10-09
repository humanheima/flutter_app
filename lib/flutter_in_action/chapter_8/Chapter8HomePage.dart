import 'package:flutter/material.dart';

import 'Code8_1.dart';
import 'Code8_2.dart';
import 'Code8_3.dart';
import 'Code8_4.dart';

///
/// Created by dumingwei on 2019-10-09.
/// Desc:
///
class Chapter8HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bus.on("login", (arg) {
      print("收到登录事件");
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('第8章'),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
              child: Text('8.1 原始指针事件处理'),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return PointerEventTestRoute();
                }));
              }),
          RaisedButton(
            child: Text(
              "8.2 手势识别GestureDetector",
            ),
            onPressed: () {
              Navigator.push(context, new MaterialPageRoute(builder: (context) {
                return GestureDetectorTestRoute();
              }));
            },
          ),
          RaisedButton(
            child: Text(
              "8.3 事件总线,发送事件",
            ),
            onPressed: () {
              bus.emit("login", "用户登录了");
            },
          ),
          RaisedButton(
            child: Text(
              "8.4 Notification",
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
        ],
      ),
    );
  }
}
