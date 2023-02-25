import 'package:flutter/material.dart';

///
/// Crete by dumingwei on 2019/3/18
/// Desc:线性布局 Row、Column
///
/// 如果Row里面嵌套Row，或者Column里面再嵌套Column，那么只有对最外面的Row或Column会占用尽可能大的空间，
/// 里面Row或Column所占用的空间为实际大小

class RowColumnWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text(
        "线性布局类Widgets",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(" hello world "),
                    Text(" I am Jack "),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(" hello world "),
                    Text(" I am Jack "),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    Text(" hello world "),
                    Text(" I am Jack "),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  ///由下向上排列
                  verticalDirection: VerticalDirection.up,
                  children: <Widget>[
                    Text(
                      " hello world ",
                      style: TextStyle(fontSize: 30.0),
                    ),
                    Text(" I am Jack "),
                  ],
                ),
                CenterColumnWidget(),
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

class CenterColumnWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text("hi"),
        Text("world"),
      ],
    );
  }
}
