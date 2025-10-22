import 'package:flutter/material.dart';

///
/// Created by dumingwei on 2019-09-12.
/// Desc:接受传递的参数（一个提示文本参数），将传入它的文本显示在页面上。
/// 添加一个“返回”按钮，点击后在返回上一个路由的同时会带上一个返回参数。
///

class TipRoute extends StatelessWidget {
  final String text;

  TipRoute({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('提示'),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(text),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, "我是返回值"),
                child: Text('返回'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
