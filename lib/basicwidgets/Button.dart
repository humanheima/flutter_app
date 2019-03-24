import 'package:flutter/material.dart';
import 'dart:core';

///悬浮按钮
class MyButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("按钮"),
      ),
      body: new Container(
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
            FlatButton(
              color: Colors.blue,
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
