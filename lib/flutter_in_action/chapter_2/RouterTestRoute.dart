import 'package:flutter/material.dart';
import 'TipRoute.dart';

///
/// Created by dumingwei on 2019-09-12.
/// Desc: 测试路由传值
///

class RouterTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('提示'),
      ),
      body: Center(
        child: RaisedButton(
            onPressed: () async {
              var result = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                return TipRoute(
                  text: "我是提示xxx",
                );
              }));
              print("路由返回值：$result");
            },
            child: Text('打开提示页')),
      ),
    );
  }
}
