import 'package:flutter/material.dart';

///
/// Created by dumingwei on 2019-10-07.
/// Desc:
///

class DecoratedWidgetRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('5.3 装饰容器DecoratedBox'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 20.0,
          ),
          Align(
            alignment: Alignment.center,
            child: DecoratedBox(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.red, Colors.orange.shade700]), //背景渐变
                    borderRadius: BorderRadius.circular(3.0), //3像素圆角
                    boxShadow: [
                      //阴影
                      BoxShadow(
                          color: Colors.black54,
                          offset: Offset(2.0, 2.0),
                          blurRadius: 4.0)
                    ]),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 60.0, vertical: 18.0),
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
