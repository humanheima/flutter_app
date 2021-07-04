import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Code10_2.dart';
import 'Code10_3.dart';
import 'Code10_4.dart';
import 'Code10_5.dart';

///
/// Created by dumingwei on 2019-10-11.
/// Desc:
///
class Chapter10HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义组件'),
      ),
      body: ListView(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(new MaterialPageRoute(builder: (BuildContext context) {
                return GradientButtonRoute();
              }));
            },
            child: Text('10.2 组合现有组件'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(new MaterialPageRoute(builder: (BuildContext context) {
                return TurnBoxRoute();
              }));
            },
            child: Text('10.3 组合实例：TurnBox'),
          ),
          RaisedButton(
            child: Text(
              "10.4 自绘组件 （CustomPaint与Canvas）",
            ),
            onPressed: () {
              Navigator.push(context,
                  new CupertinoPageRoute(builder: (context) {
                return CustomPaintRoute();
              }));
            },
          ),
          RaisedButton(
            child: Text(
              "10.5 自绘实例：圆形背景渐变进度条",
            ),
            onPressed: () {
              Navigator.push(context,
                  new CupertinoPageRoute(builder: (context) {
                return GradientCircularProgressRoute();
              }));
            },
          ),
        ],
      ),
    );
  }
}
