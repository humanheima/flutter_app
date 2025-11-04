import 'package:flutter/material.dart';

///
/// Created by 杜明伟 on 2023/2/27.
///PageView与页面缓存，给PageView添加缓存

class TestPageViewCacheRoute extends StatelessWidget {
  TestPageViewCacheRoute();

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    for (int i = 0; i < 6; i++) {
      children.add(Page2(
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

class Page2 extends StatefulWidget {
  Page2({Key? key, required this.text});

  final String text;

  @override
  State<StatefulWidget> createState() {
    return _Page2State();
  }
}

class _Page2State extends State<Page2> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context); // 必须调用
    print('build ${widget.text}');
    return Center(
      child: Text(
        '${widget.text}',
        textScaler: const TextScaler.linear(5),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
