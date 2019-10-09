import 'dart:core';

import 'package:flutter/material.dart';

///悬浮按钮
class MyButtonWidget extends StatelessWidget {
  void _onPressed() {}

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("3.4按钮"),
      ),
      body: new Container(
        alignment: Alignment(0.0, 0.0),
        child: new Column(
          children: <Widget>[
            RaisedButton(
                child: Text("normal"),
                //onPressed: () => print("button was pressed")),
                onPressed: () {
                  print("RaisedButton was pressed");
                }),
            FlatButton(
              child: Text("FlatButton"),
              onPressed: () => debugPrint("FlatButton was pressed"),
            ),
            OutlineButton(
              child: Text("OutlineButton"),
              onPressed: () => debugPrint("OutlineButton was pressed"),
            ),
            IconButton(
              icon: Icon(Icons.thumb_up),
              onPressed: () => debugPrint("OutlineButton was pressed"),
            ),
            RaisedButton.icon(
                icon: Icon(Icons.send), label: Text('发送'), onPressed: () {}),
            OutlineButton.icon(
              icon: Icon(Icons.add),
              label: Text("添加"),
              onPressed: _onPressed,
            ),
            FlatButton.icon(
              icon: Icon(Icons.info),
              label: Text("详情"),
              onPressed: _onPressed,
            ),
            RaisedButton(
              color: Colors.blue,
              //按下时候的颜色
              colorBrightness: Brightness.dark,
              highlightColor: Colors.blue[700],
              splashColor: Colors.grey,
              child: Text("Submit"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              onPressed: () => {},
            )
          ],
        ),
      ),
    );
  }
}
