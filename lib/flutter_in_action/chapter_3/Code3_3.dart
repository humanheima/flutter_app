import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

///
/// Created by dumingwei on 2019-10-06.
/// Desc:3.3文本、字体样式
///

///

const _textStyle = const TextStyle(
  fontFamily: 'Big_Shoulders_Display',
);

class TextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text(
        "3.3文本、字体样式",
      )),
      backgroundColor: Colors.white,
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Text(
              "hello world",
              textAlign: TextAlign.left,
            ),
            new Text(
              "Hello world! I'm Jack. " * 5,
              style: new TextStyle(color: Colors.green, fontSize: 20),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "缩放字体大小为默认的1.5倍",
              textAlign: TextAlign.center,
              textScaleFactor: 1.5,
            ),
            Container(
              height: 40.0,
            ),
            Text(
              "Hello world",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18.0,
                  //指定行高
                  height: 1.2,
                  fontFamily: "Courier",
                  background: new Paint()..color = Colors.yellow,
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.dashed),
            ),
            Text.rich(TextSpan(
              children: [
                TextSpan(text: "Home: "),
                TextSpan(

                    text: "https://flutterchina.club",
                    style: TextStyle(color: Colors.blue,fontSize: 20),
                    recognizer: new TapGestureRecognizer())
              ],
            )),
            Container(
              height: 40.0,
            ),
            new Column(
              children: <Widget>[
                DefaultTextStyle(
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20.0,
                  ),
                  textAlign: TextAlign.start,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("hello world"),
                      Text("I am Jack"),
                      Text(
                        'I am Jack',
                        style: TextStyle(inherit: false, color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: 40.0,
            ),
            Text(
              '字体',
              style: _textStyle,
            )
          ],
        ),
      ),
    );
  }
}
