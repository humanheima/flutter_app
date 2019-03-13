import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// 文本、字体样式
class TextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text(
        "Text and style",
      )),
      backgroundColor: Colors.white,
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Text(
              "hello world",
              textAlign: TextAlign.center,
            ),
            new Text(
              "Hello world! I'm Jack. " * 4,
              style: new TextStyle(color: Colors.green, fontSize: 20),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "hello world hello world" * 4,
              textAlign: TextAlign.center,
              textScaleFactor: 1.5,
            ),
            Text(
              "Hello world",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18.0,
                  height: 1.2,
                  fontFamily: "Courier",
                  background: new Paint()..color = Colors.yellow,
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.dashed),
            ),
            Text.rich(TextSpan(
              children: [
                TextSpan(text: "Home"),
                TextSpan(
                    text: "https://flutterchina.club",
                    style: TextStyle(color: Colors.blue),
                recognizer: new TapGestureRecognizer())
              ],
            ))
          ],
        ),
      ),
    );
  }
}
