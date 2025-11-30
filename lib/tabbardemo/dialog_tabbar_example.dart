import 'package:flutter/material.dart';

/// 显示包含 TabBar 的对话框
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
              maxHeight: 400, // 最大高度 400dp
              maxWidth: MediaQuery.of(context).size.width * 0.9,
            ),
            child: DialogTabBarWidget(),
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

/// 弹窗中的 TabBar 组件
class DialogTabBarWidget extends StatefulWidget {
  @override
  _DialogTabBarWidgetState createState() => _DialogTabBarWidgetState();
}

class _DialogTabBarWidgetState extends State<DialogTabBarWidget>
    with TickerProviderStateMixin {
  TabController? _tabController;

  final List<DialogTabItem> _tabs = [
    DialogTabItem(
      '基本信息',
      Icons.info_outline,
      [
        '姓名：张三',
        '年龄：28岁',
        '职业：软件工程师',
        '城市：北京',
        '邮箱：zhangsan@example.com',
        '电话：138****8888',
        '地址：北京市朝阳区某某街道某某号',
      ],
    ),
    DialogTabItem(
      '工作经历',
      Icons.work_outline,
      [
        '2020-至今：某科技公司 - 高级软件工程师',
        '• 负责移动端应用开发',
        '• 参与架构设计和技术选型',
        '• 带领团队完成多个重要项目',
        '',
        '2018-2020：某互联网公司 - 软件工程师',
        '• 负责前端页面开发',
        '• 参与产品需求分析',
        '• 优化系统性能和用户体验',
        '',
        '2016-2018：某小型公司 - 初级开发工程师',
        '• 学习各种开发技术',
        '• 参与小型项目开发',
        '• 积累项目经验',
      ],
    ),
    DialogTabItem(
      '技能特长',
      Icons.star_outline,
      [
        '编程语言：',
        '• Java、Kotlin、Dart',
        '• JavaScript、TypeScript',
        '• Python、Go',
        '',
        '开发框架：',
        '• Flutter、React Native',
        '• Spring Boot、Node.js',
        '• Vue.js、React.js',
        '',
        '数据库：',
        '• MySQL、PostgreSQL',
        '• Redis、MongoDB',
        '',
        '其他技能：',
        '• Docker、Kubernetes',
        '• Git、Jenkins',
        '• AWS、阿里云',
        '• 微服务架构设计',
        '• RESTful API 设计',
        '• 性能优化',
      ],
    ),
    DialogTabItem(
      '项目经验',
      Icons.folder_outlined,
      [
        '项目1：某电商移动应用',
        '• 技术栈：Flutter + Dart',
        '• 负责整体架构设计',
        '• 实现了商品浏览、购物车、支付等核心功能',
        '• 用户量：100万+',
        '',
        '项目2：企业管理系统',
        '• 技术栈：Spring Boot + Vue.js',
        '• 负责后端API开发',
        '• 实现了权限管理、数据分析等功能',
        '• 提升了企业工作效率30%',
        '',
        '项目3：在线教育平台',
        '• 技术栈：React Native + Node.js',
        '• 负责移动端开发',
        '• 实现了视频播放、在线考试、学习进度跟踪',
        '• 月活跃用户：50万+',
        '',
        '项目4：物联网监控系统',
        '• 技术栈：Java + Spring Cloud',
        '• 负责微服务架构设计',
        '• 实现了设备管理、数据采集、告警系统',
        '• 支持10万+设备同时在线',
      ],
    ),
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 对话框标题栏
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
              Icon(Icons.person, color: Colors.blue[700]),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  '个人详细信息',
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
            isScrollable: true,
            labelColor: Colors.blue[700],
            unselectedLabelColor: Colors.grey[600],
            indicatorColor: Colors.blue[700],
            indicatorWeight: 2,
            labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            unselectedLabelStyle: TextStyle(fontSize: 14),
            tabs: _tabs.map((DialogTabItem item) {
              return Tab(
                icon: Icon(item.icon, size: 20),
                text: item.title,
              );
            }).toList(),
          ),
        ),

        // TabBarView - 自适应高度，最高 400dp，可滚动
        Flexible(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: 300, // 留出标题和TabBar的空间
            ),
            child: TabBarView(
              controller: _tabController,
              children: _tabs.map((DialogTabItem item) {
                return SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: item.content.map((String text) {
                      if (text.isEmpty) {
                        return SizedBox(height: 8);
                      }

                      bool isHeader =
                          text.endsWith('：') && !text.startsWith('•');
                      bool isBulletPoint = text.startsWith('•');

                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          text,
                          style: TextStyle(
                            fontSize: isHeader ? 15 : 14,
                            fontWeight:
                                isHeader ? FontWeight.w600 : FontWeight.normal,
                            color: isHeader
                                ? Colors.blue[700]
                                : isBulletPoint
                                    ? Colors.grey[700]
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
        ),

        // 底部按钮区域
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('取消'),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('信息已确认')),
                  );
                },
                child: Text('确认'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// 对话框 Tab 项数据类
class DialogTabItem {
  final String title;
  final IconData icon;
  final List<String> content;

  DialogTabItem(this.title, this.icon, this.content);
}
