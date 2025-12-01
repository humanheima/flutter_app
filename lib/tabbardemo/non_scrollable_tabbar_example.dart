import 'package:flutter/material.dart';
import 'package:flutter_app/tabbardemo/RoundedRectangleTabIndicator.dart';

/// 例子2：不可滚动的 TabBar
class NonScrollableTabBarExample extends StatefulWidget {
  @override
  _NonScrollableTabBarExampleState createState() =>
      _NonScrollableTabBarExampleState();
}

class _NonScrollableTabBarExampleState extends State<NonScrollableTabBarExample>
    with TickerProviderStateMixin {
  TabController? _tabController;

  final List<TabItem> _tabs = [
    TabItem('首页', Icons.home, Colors.blue),
    TabItem('消息', Icons.message, Colors.green),
    TabItem('发现', Icons.explore, Colors.orange),
    TabItem('我的', Icons.person, Colors.purple),
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
        title: Text('不可滚动的 TabBar'),
        bottom: TabBar(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 0),
          controller: _tabController,
          isScrollable: false, // 设置为不可滚动，Tab 会平均分布
          labelColor: Colors.white, //选中颜色tab文字颜色，不是下划线颜色
          unselectedLabelColor: Colors.white70, //未选中颜色tab文字颜色，不是下划线颜色
          indicatorSize: TabBarIndicatorSize.label, // 指示器大小为标签的宽度
          dividerColor: Colors.transparent, //去掉tabbar下边的线
          indicator: const RoundedRectangleTabIndicator(
            color: Colors.blue,
            height: 4, // 高度
            radius: 4, // 圆角半径（越大越圆，通常 4~8）
            padding: EdgeInsets.symmetric(horizontal: 0), // 左右留白（可调）
            //bottomMargin: 6, // 距离文字底部的间距（关键！）
            bottomMargin: 2,
          ),
          //indicatorSize:TabBarIndicatorSize.tab ,//会占满整个tab的宽度，比如有4个tab，每个tab的宽度是屏幕宽度的1/4

          //indicatorColor: Colors.white,
          //indicatorWeight: 3,
          tabs: _tabs.map((TabItem item) {
            //指定tab的高度
            return Container(
              //height: 48,  // 这里可以指定高度，来解决indicator位置不对的问题
              //decoration: BoxDecoration(color: Colors.black),
              child: Tab(
                text: item.name,
                icon: Icon(item.icon),
              ),
            );
          }).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabs.map((TabItem item) {
          return Container(
            color: item.color.withOpacity(0.1),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    item.icon,
                    size: 80,
                    color: item.color,
                  ),
                  SizedBox(height: 20),
                  Text(
                    '${item.name} 页面',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: item.color,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '这是 ${item.name} 的内容区域',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 20),
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            '特性说明：',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '• TabBar 设置 isScrollable: false\n'
                            '• Tab 会平均分布在整个宽度上\n'
                            '• 适用于标签数量较少的场景\n'
                            '• 每个 Tab 都有图标和文字',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          if (_tabController!.index > 0) {
                            _tabController!
                                .animateTo(_tabController!.index - 1);
                          }
                        },
                        icon: Icon(Icons.arrow_back),
                        label: Text('上一个'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: item.color),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (_tabController!.index < _tabs.length - 1) {
                            _tabController!
                                .animateTo(_tabController!.index + 1);
                          }
                        },
                        icon: Icon(Icons.arrow_forward),
                        label: Text('下一个'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: item.color),
                      ),
                    ],
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

/// Tab 项数据类
class TabItem {
  final String name;
  final IconData icon;
  final Color color;

  TabItem(this.name, this.icon, this.color);
}
