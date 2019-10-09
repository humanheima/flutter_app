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
    return Scaffold();
  }
}
