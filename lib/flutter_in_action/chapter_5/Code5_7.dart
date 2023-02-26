import 'package:flutter/material.dart';

///
/// Created by dumingwei on 2019-10-07.
/// Desc:剪裁（Clip）
///
class ClipTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget avatar = Image.asset("images/avatar.png");
    return Scaffold(
      appBar: AppBar(
        title: Text('5.7 剪裁（Clip）'),
      ),
      body: new Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            avatar,
            Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            ClipOval(
              child: avatar,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            //剪裁为圆角矩形
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: avatar,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  //宽度设为原来宽度一半，另一半会溢出
                  widthFactor: 0.5,
                  child: avatar,
                ),
                Text(
                  "你好世界",
                  style: TextStyle(color: Colors.green),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipRect(
                  //将溢出部分剪裁
                  child: Align(
                    alignment: Alignment.topLeft,
                    widthFactor: 0.5,
                    child: avatar,
                  ),
                ),
                Text(
                  "你好世界",
                  style: TextStyle(color: Colors.green),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.red),
              child: ClipRect(
                clipper: MyClipper(),
                child: avatar,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(10.0, 15.0, 40.0, 30.0);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}
