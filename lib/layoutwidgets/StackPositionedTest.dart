import 'package:flutter/material.dart';

///
/// Crete by dumingwei on 2019/3/19
/// Desc: 层叠布局
///
class StackPositionedRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text(
        "布局类Widgets",
      )),
      backgroundColor: Colors.white,
      //通过ConstrainedBox来确保Stack占满屏幕
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          fit: StackFit.expand, //未定位widget占满Stack整个空间
          alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
          children: <Widget>[
            Positioned(
              child: Text("I am jack"),
              left: 18.0,
            ),
            Container(
              child: Text(
                "Hello world",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.red,
            ),

            Positioned(
              child: Text("Your friend"),
              top: 18.0,
            ),
            //Flex的两个子widget按1：2来占据水平空间
          ],
        ),
      ),
    );
  }
}
