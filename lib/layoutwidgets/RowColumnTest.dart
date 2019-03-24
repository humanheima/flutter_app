import 'package:flutter/material.dart';

///
/// Crete by dumingwei on 2019/3/18
/// Desc:线性布局 Row、Column
///

class RowColumnWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text(
        "布局类Widgets",
      )),
      backgroundColor: Colors.white,
      body: Container(
          color: Colors.green,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max, //有效，外层Column高度为整个屏幕
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: Colors.red,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center, //垂直方向居中对齐
                      children: <Widget>[
                        Text("hello world "),
                        Text("I am Jack "),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }

  Padding buildPadding() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max, //有效，外层Column高度为整个屏幕
        children: <Widget>[
          Container(
            color: Colors.red,
            child: Column(
              mainAxisSize: MainAxisSize.max, //无效，内层Colum高度为实际高度
              children: <Widget>[
                Text("hello world "),
                Text("I am Jack "),
              ],
            ),
          )
        ],
      ),
    );
  }

  Column buildRow() {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(" hello world "),
            Text(" i am jack "),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(" hello world "),
            Text(" i am jack "),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Text(" hello world "),
            Text(" i am jack "),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          verticalDirection: VerticalDirection.up,
          children: <Widget>[
            Text(
              " hello world ",
              style: TextStyle(fontSize: 30.0),
            ),
            Text(" i am jack "),
          ],
        ),
      ],
    );
  }
}
