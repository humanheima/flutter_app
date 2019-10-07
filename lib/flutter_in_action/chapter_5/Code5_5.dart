import 'package:flutter/material.dart';

///
/// Created by dumingwei on 2019-10-07.
/// Desc:
///
class ContainerTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('5.5 Container'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20.0, left: 120.0),
            constraints: BoxConstraints.tightFor(width: 200.0, height: 150.0),
            //卡片大小
            decoration: BoxDecoration(
                gradient: RadialGradient(
                    //雷达渐变
                    colors: [Colors.red, Colors.orange],
                    center: Alignment.topLeft,
                    radius: .98),
                boxShadow: [
                  //卡片阴影
                  BoxShadow(
                      color: Colors.black54,
                      offset: Offset(2.0, 2.0),
                      blurRadius: 4.0)
                ]),
            transform: Matrix4.rotationZ(.2),
            alignment: Alignment.center,
            child: Text(
              "5.20",
              style: TextStyle(color: Colors.white, fontSize: 40.0),
            ),
          )
        ],
      ),
    );
  }
}
