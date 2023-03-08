import 'package:flutter/material.dart';

///
/// Created by 杜明伟 on 2023/3/8.
/// 测试 6.10 CustomScrollView 和 Slivers

class Code610 extends StatelessWidget {
  Code610();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('测试 6.10 CustomScrollView 和 Slivers'),
      ),
      body: buildTwoSliverList(),
    );
  }

  Widget buildTwoSliverList() {
    SliverFixedExtentList listView1 = SliverFixedExtentList(
        itemExtent: 56,
        delegate:
            new SliverChildBuilderDelegate((BuildContext context, int index) {
          return ListTile(
            title: Text('$index'),
          );
        }, childCount: 10));

    SliverFixedExtentList listView2 = SliverFixedExtentList(
        itemExtent: 56,
        delegate:
            new SliverChildBuilderDelegate((BuildContext context, int index) {
          return ListTile(
            title: Text('$index'),
          );
        }, childCount: 10));

    return CustomScrollView(
      slivers: [
        listView1,
        listView2,
      ],
    );
  }
}
