import 'package:flutter/material.dart';
import 'dart:math' as math;

///
/// Crete by dumingwei on 2019/3/19
/// Desc: Transform 平移，旋转，操作
///
///

class TransformTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("5.4 变换（Transform）"),
      ),
      body: Container(
        //上下左右各添加16像素补白
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
                color: Colors.black,
                margin: EdgeInsets.only(top: 30.0),
                child: new Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.deepOrange,
                  child: const Text('Apartment'),
                )),
            Container(
              color: Colors.black,
              margin: EdgeInsets.only(top: 30.0),
              child: new Transform(
                alignment: Alignment.topRight, //相对于坐标系原点的对齐方式
                transform: new Matrix4.skewY(0.3), //沿Y轴倾斜0.3弧度
                child: new Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.deepOrange,
                  child: const Text('Apartment'),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.red),
                child: Transform.translate(
                  offset: Offset(0.0, 0.0),
                  child: Text("Hello"),//用来做对比
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.red),
                //平移，默认原点为左上角，左移20像素，向上平移5像素
                child: Transform.translate(
                  offset: Offset(-20.0, -5.0),
                  child: Text("Hello"),
                ),
              ),
            ),

            ///先平移再旋转
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.red),
                //平移，默认原点为左上角，左移20像素，向上平移5像素
                child: Transform.translate(
                  offset: Offset(-20.0, -5.0),
                  child: Transform.rotate(
                    //旋转90度
                    angle: math.pi / 2,
                    child: Text("Hello"),
                  ),
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 80.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.blueAccent),
                  child: Transform.rotate(
                    //旋转90度
                    angle: math.pi / 2,
                    child: Text("Hello"),
                  ),
                )),

            ///先旋转再平移
            Container(
                margin: EdgeInsets.only(top: 80.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.red),
                  child: Transform.rotate(
                    //旋转90度
                    angle: math.pi / 2,
                    child: Transform.translate(
                      offset: Offset(-20.0, -5.0),
                      child: Text("Hello"),
                    ),
                  ),
                )),

            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
              child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.red),
                  //缩放，放大到1.5倍
                  child: Transform.scale(scale: 1.5, child: Text("Hello world"))),
            ),

            ///Transform的变换是应用在绘制阶段，而并不是应用在布局(layout)阶段，所以无论对子widget应用何种变化，
            ///其占用空间的大小和在屏幕上的位置都是固定不变的，因为这些是在布局阶段就确定的。
            ///由于第一个Text应用变换(放大)后，其在绘制时会放大，但其占用的空间依然为红色部分，
            ///所以第二个text会紧挨着红色部分，最终就会出现文字有重合部分。
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DecoratedBox(
                    decoration: BoxDecoration(color: Colors.red),
                    child: Transform.scale(
                        scale: 1.5, child: Text("Hello world"))),
                Text(
                  "你好",
                  style: TextStyle(color: Colors.green, fontSize: 18.0),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DecoratedBox(
                  decoration: BoxDecoration(color: Colors.red),
                  //将Transform.rotate换成RotatedBox,RotatedBox的变换是在layout阶段，会影响在子widget的位置和大小。
                  child: RotatedBox(
                    quarterTurns: 1, //旋转90度(1/4圈)
                    child: Text("Hello world"),
                  ),
                ),
                Text(
                  "你好",
                  style: TextStyle(color: Colors.green, fontSize: 18.0),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
