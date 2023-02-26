import 'package:flutter/material.dart';

///
/// Crete by dumingwei on 2019/3/19
/// Desc: Padding 填充
///

class PaddingTestRoute extends StatelessWidget {
  final Widget redBox =
      DecoratedBox(decoration: BoxDecoration(color: Colors.red));
  final Widget greenBox =
      DecoratedBox(decoration: BoxDecoration(color: Colors.green));

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("5.1 填充（Padding）"),
      ),
      body: Padding(
        //上下左右各添加16像素补白
        padding: EdgeInsets.all(16.0),
        child: Column(
          //显式指定对齐方式为左对齐，排除对齐干扰
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              //左边添加8像素补白
              padding: const EdgeInsets.only(left: 8.0),
              child: Text("Hello world"),
            ),
            Padding(
              //上下各添加8像素补白
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text("I am Jack"),
            ),
            Padding(
              // 分别指定四个方向的补白
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
              child: Text("Your friend"),
            ),
          ],
        ),
      ),
    );
  }
}
