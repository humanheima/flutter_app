import 'package:flutter/material.dart';

///
/// Created by dumingwei on 2019-09-30.
/// Desc:
///

class ContextRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Context测试"),
      ),
      body: Container(
        child: Builder(builder: (context) {
          // 在Widget树中向上查找最近的父级`Scaffold` widget
          final Scaffold? scaffold = context.findAncestorWidgetOfExactType<Scaffold>();
          // 如果找到了 Scaffold，并且其 appBar 是 AppBar，则返回 title（Widget?），否则返回一个fallback
          final preferred = scaffold?.appBar;
          if (preferred is AppBar) {
            return preferred.title ?? SizedBox.shrink();
          }
          // 找不到时显示一条友好的提示，而不是发生空引用异常
          return Text('No AppBar title found');
        }),
      ),
    );
  }
}
