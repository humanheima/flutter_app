import 'package:flutter/material.dart';

///
/// Created by 杜明伟 on 2023/2/27.
///测试 TabBarView

class TestTabViewRoute1 extends StatefulWidget {
  @override
  _TestTabViewRoute1State createState() => new _TestTabViewRoute1State();
}

class _TestTabViewRoute1State extends State<TestTabViewRoute1>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List tabs = ['新闻', '历史', '图片'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('测试TabBarView'),
        bottom: TabBar(
          controller: _tabController,
          tabs: tabs
              .map((e) => Tab(
                    text: e,
                  ))
              .toList(),
        ),
      ),
      body: TabBarView(
          controller: _tabController,
          children: tabs.map((e) {
            return KeepAlive(
                keepAlive: true,
                child: Text(
                  e,
                  textScaler: const TextScaler.linear(5),
                ));
          }).toList()),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
