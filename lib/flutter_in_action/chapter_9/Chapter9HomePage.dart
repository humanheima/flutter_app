import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Code9_2.dart';
import 'Code9_3.dart';
import 'Code9_4_1.dart';
import 'Code9_5.dart';
import 'Code9_6.dart';
import 'Code9_7.dart';

///
/// Created by dumingwei on 2019-10-10.
/// Desc:
///
class Chapter9HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第9章：动画'),
      ),
      body: ListView(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(new CupertinoPageRoute(builder: (context) {
                return ScaleAnimationRoute();
              }));
            },
            child: Text('9.2 动画基本结构及状态监听'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 500),
                      pageBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation) {
                        return FadeTransition(
                          opacity: animation,
                          child: ScaleAnimationRoute(),
                        );
                      }));
            },
            child: Text('使用PageRouteBuilder'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).push(new FadeRoute(builder: (context) {
                return ScaleAnimationRoute();
              }));
            },
            child: Text('继承PageRoute实现自定义路由'),
          ),
          RaisedButton(
            child: Text("9.4 Hero动画"),
            onPressed: () {
              Navigator.push(context,
                  new CupertinoPageRoute(builder: (context) {
                return HeroAnimationRoute();
              }));
            },
          ),
          RaisedButton(
            child: Text("9.5 交织动画"),
            onPressed: () {
              Navigator.push(context,
                  new CupertinoPageRoute(builder: (context) {
                return StaggerDemo();
              }));
            },
          ),
          RaisedButton(
            child: Text('9.6 通用"切换动画"组件（AnimatedSwitcher）'),
            onPressed: () {
              Navigator.push(context,
                  new CupertinoPageRoute(builder: (context) {
                return AnimatedSwitcherCounterRoute();
              }));
            },
          ),
          RaisedButton(
            child: Text('9.7 动画过渡组件'),
            onPressed: () {
              Navigator.push(context,
                  new CupertinoPageRoute(builder: (context) {
                return Code9_7();
                //return AnimatedWidgetsTest();
              }));
            },
          ),
        ],
      ),
    );
  }
}
