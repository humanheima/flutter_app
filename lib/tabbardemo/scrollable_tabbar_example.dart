import 'package:flutter/material.dart';

/// 例子1：可滚动的 TabBar
class ScrollableTabBarExample extends StatefulWidget {
  @override
  _ScrollableTabBarExampleState createState() =>
      _ScrollableTabBarExampleState();
}

class _ScrollableTabBarExampleState extends State<ScrollableTabBarExample>
    with TickerProviderStateMixin {
  TabController? _tabController;

  final List<String> _tabs = [
    '首页',
    '热门推荐',
    '科技新闻',
    '娱乐八卦',
    '体育赛事',
    '财经资讯',
    '汽车频道',
    '房产动态',
    '美食天地',
    '旅游攻略'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('可滚动的 TabBar'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true, // 设置为可滚动
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontSize: 14),
          tabs: _tabs.map((String name) => Tab(text: name)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabs.map((String name) {
          return Container(
            color: Colors
                .primaries[_tabs.indexOf(name) % Colors.primaries.length]
                .withOpacity(0.1),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.tab,
                    size: 80,
                    color: Colors.primaries[
                        _tabs.indexOf(name) % Colors.primaries.length],
                  ),
                  SizedBox(height: 20),
                  Text(
                    '$name 页面内容',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.primaries[
                          _tabs.indexOf(name) % Colors.primaries.length],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '这是第 ${_tabs.indexOf(name) + 1} 个标签页',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('点击了 $name 页面的按钮')),
                      );
                    },
                    child: Text('点击我'),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
