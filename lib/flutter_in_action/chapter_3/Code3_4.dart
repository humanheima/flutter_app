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
            ElevatedButton(
                child: Text("normal"),
                //onPressed: () => print("button was pressed")),
                onPressed: () {
                  print("ElevatedButton was pressed");
                }),
            TextButton(
              child: Text("TextButton"),
              onPressed: () => debugPrint("TextButton was pressed"),
            ),
            OutlinedButton(
              child: Text("OutlinedButton"),
              onPressed: () => debugPrint("OutlinedButton was pressed"),
            ),
            IconButton(
              icon: Icon(Icons.thumb_up),
              onPressed: () => debugPrint("OutlinedButton was pressed"),
            ),
            ElevatedButton.icon(
                icon: Icon(Icons.send), label: Text('发送'), onPressed: () {}),
            OutlinedButton.icon(
              icon: Icon(Icons.add),
              label: Text("添加"),
              onPressed: _onPressed,
            ),
            TextButton.icon(
              icon: Icon(Icons.info),
              label: Text("详情"),
              onPressed: _onPressed,
            ),
            ElevatedButton(
              child: Text("Submit"),
              onPressed: () => {},
            )
          ],
        ),
      ),
    );
  }
}
