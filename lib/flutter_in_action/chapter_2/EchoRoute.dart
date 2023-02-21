import 'package:flutter/material.dart';

///
/// Created by dumingwei on 2019-09-12.
/// Desc:命名路由参数传递
///
class EchoRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments;
    print(args);
    return Scaffold(
      appBar: AppBar(
        title: Text('我是命名路由打开的界面，并传递给我参数'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("参数是：$args")],
        ),
      ),
    );
  }
}
