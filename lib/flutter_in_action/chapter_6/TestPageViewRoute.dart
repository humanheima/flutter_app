import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';

///
/// Created by 杜明伟 on 2023/2/27.
///PageView与页面缓存
///测试使用 KeepAliveWrapper 缓存控件。

class TestPageViewRoute extends StatelessWidget {
  TestPageViewRoute();

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    for (int i = 0; i < 6; i++) {
      children.add(KeepAliveWrapper(
          child: Page(
        text: '$i',
      )));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('PageView与页面缓存'),
      ),
      body: PageView(
        children: children,
        //左右各缓存一页
        //allowImplicitScrolling: true,
      ),
    );
    // return Material(
    //   child: PageView(
    //     children: children,
    //   ),
    // );
  }
}

class Page extends StatefulWidget {
  Page({Key? key, required this.text});

  final String text;

  @override
  State<StatefulWidget> createState() {
    return _PageState();
  }
}

class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    print('build ${widget.text}');
    return Center(
      child: Text(
        '${widget.text}',
        textScaler: const TextScaler.linear(5),
      ),
    );
  }
}
