import 'package:flutter/material.dart';
import 'package:flutter_app/flutter_in_action/chapter8/Code8_1.dart';
import 'package:flutter_app/flutter_in_action/chapter8/Code8_2.dart';

///
/// Created by dumingwei on 2019-10-08.
/// Desc:
///
class Chapter8HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第8章'),
      ),
      body: ListView(
        children: <Widget>[
          ElevatedButton(
            child: Text("8.1 原始指针事件处理"),
            onPressed: () {
              Navigator.push(context, new MaterialPageRoute(builder: (context) {
                return Code81();
              }));
            },
          ),
          ElevatedButton(
            child: Text("8.2 手势识别"),
            onPressed: () {
              Navigator.push(context, new MaterialPageRoute(builder: (context) {
                //return Code82();
                //return DragTest();
                //return ScaleTest();
                return GestureRecognizer();
              }));
            },
          ),
        ],
      ),
    );
  }
}
