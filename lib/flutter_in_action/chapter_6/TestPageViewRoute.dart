import 'package:flutter/material.dart';

///
/// Created by 杜明伟 on 2023/2/27.
///PageView与页面缓存

class TestPageViewRoute extends StatelessWidget {
  TestPageViewRoute();

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    for (int i = 0; i < 6; i++) {
      children.add(Page(
        text: '$i',
      ));
    }
    return Material(
      child: PageView(
        children: children,
      ),
    );
  }
}

class Page extends StatefulWidget {
  Page({Key key, this.text});

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
        textScaleFactor: 5,
      ),
    );
  }
}
