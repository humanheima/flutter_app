import 'package:flutter/material.dart';

///
/// Created by dumingwei on 2025/11/30
/// Desc: 页面描述,显示自适应高度的 TabBar 对话框
/// 通过切换tab的时候，动态计算一下高度。
/// 如果高度超过300dp，则设置为300dp，并且内容可滚动。否则根据内容高度自适应。
///
/// 
void showTabBarDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    barrierColor: Colors.black54,
    transitionDuration: Duration(milliseconds: 300),
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return Center(
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  spreadRadius: 0,
                ),
              ],
            ),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.9,
            ),
            child: AdaptiveTabBarWidget(),
          ),
        ),
      );
    },
    transitionBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      return ScaleTransition(
        scale: Tween<double>(begin: 0.8, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
        ),
        child: FadeTransition(
          opacity: animation,
          child: child,
        ),
      );
    },
  );
}

/// 自适应高度的 TabBar 组件
class AdaptiveTabBarWidget extends StatefulWidget {
  @override
  _AdaptiveTabBarWidgetState createState() => _AdaptiveTabBarWidgetState();
}

class _AdaptiveTabBarWidgetState extends State<AdaptiveTabBarWidget>
    with TickerProviderStateMixin {
  TabController? _tabController;
  double _currentContentHeight = 0;

  final List<TabData> _tabs = [
    TabData(
      '基本设置',
      Icons.settings,
      [
        '账户信息',
        '用户名：flutter_user',
        '邮箱：user@example.com',
        '注册时间：2023-01-15',
        '',
        // '隐私设置',
        // '个人资料可见性：仅好友',
        // '消息接收设置：全部接收',
        // '位置信息：已关闭',
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController!.addListener(_handleTabChange);
    // 初始化时计算第一个tab的高度
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateContentHeight(0);
    });
  }

  @override
  void dispose() {
    _tabController?.removeListener(_handleTabChange);
    _tabController?.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (_tabController!.indexIsChanging) {
      _calculateContentHeight(_tabController!.index);
    }
  }

  void _calculateContentHeight(int tabIndex) {
    // 计算当前选中tab内容的预估高度
    final content = _tabs[tabIndex].content;
    double estimatedHeight = 0;

    for (String text in content) {
      if (text.isEmpty) {
        estimatedHeight += 8; // 空行高度
      } else {
        // 预估每行文字高度 (字体大小 + 行间距)
        estimatedHeight += 14 * 1.4 + 4; // fontSize * lineHeight + padding
      }
    }

    // 加上内边距
    estimatedHeight += 32; // padding top + bottom

    // 限制最大高度为300
    final newHeight = estimatedHeight > 300 ? 300.0 : estimatedHeight;

    if (newHeight != _currentContentHeight) {
      setState(() {
        _currentContentHeight = newHeight;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 标题栏
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.tune, color: Colors.blue[700]),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  '应用设置中心',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.close, color: Colors.blue[700]),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
              ),
            ],
          ),
        ),

        // TabBar
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey[300]!, width: 1),
            ),
          ),
          child: TabBar(
            controller: _tabController,
            isScrollable: false,
            labelColor: Colors.blue[700],
            unselectedLabelColor: Colors.grey[600],
            indicatorColor: Colors.blue[700],
            indicatorWeight: 2,
            labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            unselectedLabelStyle: TextStyle(fontSize: 14),
            tabs: _tabs.map((TabData item) {
              return Tab(
                icon: Icon(item.icon, size: 18),
                text: item.title,
              );
            }).toList(),
          ),
        ),

        // 动态高度的 TabBarView
        AnimatedContainer(
          duration: Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          height: _currentContentHeight,
          child: TabBarView(
            controller: _tabController,
            children: _tabs.map((TabData item) {
              return SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: item.content.map((String text) {
                    if (text.isEmpty) {
                      return SizedBox(height: 8);
                    }

                    bool isQuestion = text.startsWith('Q:');
                    bool isAnswer = text.startsWith('A:');
                    bool isHeader = !isQuestion &&
                        !isAnswer &&
                        text.length < 20 &&
                        !text.contains('：');

                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: isHeader ? 15 : 14,
                          fontWeight: isHeader || isQuestion
                              ? FontWeight.w600
                              : FontWeight.normal,
                          color: isHeader
                              ? Colors.blue[700]
                              : isQuestion
                                  ? Colors.orange[700]
                                  : isAnswer
                                      ? Colors.green[700]
                                      : Colors.grey[800],
                          height: 1.4,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            }).toList(),
          ),
        ),

        // 底部间距
        SizedBox(height: 16),
      ],
    );
  }
}

/// Tab 数据类
class TabData {
  final String title;
  final IconData icon;
  final List<String> content;

  TabData(this.title, this.icon, this.content);
}
