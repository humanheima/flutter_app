import 'package:flutter/material.dart';

///
/// Created by dumingwei on 2019-10-07.
/// Desc:
///
class AlignTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('4.6 对齐与相对定位（Align）'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 120.0,
            width: 120.0,
            color: Colors.blue[50],
            child: Align(
              alignment: Alignment.topRight,
              child: FlutterLogo(
                size: 60,
              ),
            ),
          ),
          Container(
            height: 10,
            color: Colors.grey[500],
          ),
          Container(
            color: Colors.blue[50],
            child: Align(
              widthFactor: 2,
              heightFactor: 2,
              alignment: Alignment.topRight,
              child: FlutterLogo(
                size: 60,
              ),
            ),
          ),
          Container(
            height: 10,
            color: Colors.grey[500],
          ),
          Container(
            width: 120.0,
            height: 120.0,
            color: Colors.blue[50],
            child: Align(
              alignment: FractionalOffset(0.2, 0.6),
              child: FlutterLogo(
                size: 60,
              ),
            ),
          ),
          Container(
            height: 10,
            color: Colors.grey[500],
          ),
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.red),
            child: Center(
              child: Text(
                'xxx',
                style: TextStyle(backgroundColor: Colors.blue),
              ),
            ),
          ),
          Container(
            height: 10,
            color: Colors.grey[500],
          ),
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.red),
            child: Center(
              widthFactor: 2,
              heightFactor: 1,
              child: Text(
                'xxx',
                style: TextStyle(backgroundColor: Colors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
