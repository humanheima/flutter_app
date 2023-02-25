import 'package:flutter/material.dart';

///
/// Created by dumingwei on 2019-10-07.
/// Desc:4.7 对齐与相对定位（Align）
/// Alignment Widget会以矩形的中心点作为坐标原点
///
/// FractionalOffset 的坐标原点为矩形的左侧顶点，这和布局系统的一致，所以理解起来会比较容易。
///
class AlignTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('4.7 对齐与相对定位（Align）'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 120.0,
            width: 120.0,
            color: Colors.blue[50],
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 60,
                height: 60,
                color: Colors.redAccent,
              ),
            ),
          ),
          Container(
            height: 10,
            color: Colors.grey[500],
          ),
          Container(
            color: Colors.blue[50],
            child: Align(
              widthFactor: 2, //乘以子元素的宽就是最终宽度
              heightFactor: 2,
              alignment: Alignment.topRight,
              child: Container(
                width: 60,
                height: 60,
                color: Colors.redAccent,
              ),
            ),
          ),
          Container(
            height: 10,
            color: Colors.grey[500],
          ),
          Container(
            color: Colors.blue[50],
            child: Align(
              widthFactor: 2,
              //乘以子元素的宽就是最终宽度
              heightFactor: 2,
              //最终，子View的中心点，距离Align的中心点水平距离是 1/2 child.width
              alignment: Alignment(1, 0.0),
              child: Container(
                width: 60,
                height: 60,
                color: Colors.yellowAccent,
              ),
            ),
          ),
          Container(
            height: 10,
            color: Colors.grey[500],
          ),
          Container(
            width: 120.0,
            height: 120.0,
            color: Colors.blue[50],
            child: Align(
              alignment: FractionalOffset(0.2, 0.6),
              child: FlutterLogo(
                size: 60,
              ),
            ),
          ),
          Container(
            height: 10,
            color: Colors.grey[500],
          ),
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.red),
            //Center 组件
            child: Center(
              child: Text(
                'xxx',
                style: TextStyle(backgroundColor: Colors.blue),
              ),
            ),
          ),
          Container(
            height: 10,
            color: Colors.grey[500],
          ),
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.red),
            child: Center(
              widthFactor: 2,//指定宽度是child的2倍
              heightFactor: 1,//指定高度是child的高度
              child: Text(
                'xxx',
                style: TextStyle(backgroundColor: Colors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
