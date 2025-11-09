import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 2; // "我的"页面被选中

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF040304),
      body: SafeArea(
        top: false, // 不使用SafeArea的顶部，我们自己处理状态栏
        child: Column(
          children: [
            // 自定义状态栏
            _buildCustomStatusBar(),

            // 主要内容区域
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // 顶部应用栏
                    _buildTopAppBar(),

                    // 用户信息区域
                    _buildUserProfile(),

                    // 账户信息卡片
                    _buildAccountCard(),

                    SizedBox(height: 16),

                    // 创作者中心
                    _buildCreatorCenter(),

                    // 底部留白，为浮动导航栏预留空间
                    SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // 浮动底部导航栏
      floatingActionButton: null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildFloatingBottomNavBar(),
    );
  }

  // 自定义状态栏
  Widget _buildCustomStatusBar() {
    return Container(
      height: MediaQuery.of(context).padding.top + 40,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF040304).withOpacity(0.8),
            Color(0xFF040304).withOpacity(0.6),
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          left: 16,
          right: 24,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // 设备状态图标组
            Row(
              children: [
                // 信号图标
                Icon(
                  Icons.signal_cellular_4_bar,
                  color: Colors.white,
                  size: 14,
                ),
                SizedBox(width: 4),
                // WiFi图标
                Icon(
                  Icons.wifi,
                  color: Colors.white,
                  size: 14,
                ),
                SizedBox(width: 4),
                // 电池图标
                Icon(
                  Icons.battery_full,
                  color: Colors.white,
                  size: 14,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 顶部应用栏
  Widget _buildTopAppBar() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // 消息图标
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFF6F5FA).withOpacity(0.1),
              border: Border.all(
                color: Color(0xFF040304),
                width: 1,
              ),
            ),
            child: Icon(
              Icons.message_outlined,
              color: Color(0xFFF6F5FA),
              size: 20,
            ),
          ),
          SizedBox(width: 16),

          // 设置图标
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFF6F5FA).withOpacity(0.1),
            ),
            child: Icon(
              Icons.settings_outlined,
              color: Color(0xFFF6F5FA),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  // 用户信息区域
  Widget _buildUserProfile() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          // 用户头像
          Stack(
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFFFF6B9D), Color(0xFFC44569)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.network(
                    'https://images.unsplash.com/photo-1494790108755-2616b612b789?w=200&h=200&fit=crop&crop=face',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Color(0xFFFF6B9D),
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ),
              ),
              // 编辑按钮
              Positioned(
                right: -5,
                top: 30,
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Color(0xFFF6F5FA).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.edit,
                    size: 12,
                    color: Color(0xFFF6F5FA),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16),

          // 用户名和UID
          Column(
            children: [
              // 用户名
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '用户名字用户名字',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFF6F5FA),
                      fontFamily: 'PingFang SC',
                    ),
                  ),
                ],
              ),

              SizedBox(height: 6),

              // UID
              Text(
                'UID：123456789',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF67656B),
                  fontFamily: 'PingFang SC',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 账户信息卡片
  Widget _buildAccountCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF201F20),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // 左侧图标区域
          Container(
            width: 44,
            height: 44,
            child: Stack(
              children: [
                // 背景图片效果
                Positioned(
                  left: 0,
                  top: 3,
                  child: Container(
                    width: 44,
                    height: 39,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(
                        colors: [Color(0xFFFF6B9D), Color(0xFFC44569)],
                      ),
                    ),
                  ),
                ),
                // 叠加效果图片
                Positioned(
                  left: -3,
                  top: 0,
                  child: Transform.rotate(
                    angle: 0.18,
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xFFFF6B9D).withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
                // 另一个叠加效果
                Positioned(
                  left: -7,
                  top: -10,
                  child: Transform.rotate(
                    angle: 0.24,
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xFFFF6B9D).withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 12),

          // 右侧文本信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 标题
                Text(
                  '我的账户',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFF6F5FA),
                    fontFamily: 'PingFang SC',
                  ),
                ),

                SizedBox(height: 4),

                // 戏豆数量
                Row(
                  children: [
                    Text(
                      '440',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFFF6F5FA),
                        fontFamily: 'Yuewen Font',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      '戏豆',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF67656B),
                        fontFamily: 'PingFang SC',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 创作者中心
  Widget _buildCreatorCenter() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 17),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF201F20),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题
          Text(
            '创作者中心',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFFF6F5FA),
              fontFamily: 'PingFang SC',
            ),
          ),

          SizedBox(height: 8),

          // 功能图标网格
          Row(
            children: [
              _buildCreatorItem(
                icon: Icons.add_circle,
                label: '我的作品',
                color: Color(0xFFFF6B9D),
              ),
              _buildCreatorItem(
                icon: Icons.diamond,
                label: '申请认证',
                color: Color(0xFF4ECDC4),
              ),
              _buildCreatorItem(
                icon: Icons.explore,
                label: '创作指南',
                color: Color(0xFF45B7D1),
              ),
              _buildCreatorItem(
                icon: Icons.monetization_on,
                label: '我的收益',
                color: Color(0xFFFFA726),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 创作者中心单个项目
  Widget _buildCreatorItem({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
        child: Column(
          children: [
            // 图标容器
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  colors: [
                    color,
                    color.withOpacity(0.7),
                  ],
                ),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 24,
              ),
            ),

            SizedBox(height: 4),

            // 标签文本
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFFF6F5FA),
                fontFamily: 'PingFang SC',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // 浮动底部导航栏
  Widget _buildFloatingBottomNavBar() {
    return Container(
      margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Color(0xFF171617),
          borderRadius: BorderRadius.circular(43),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: Offset(1, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(
              icon: Icons.home,
              label: '首页',
              index: 0,
              isSelected: _selectedIndex == 0,
            ),
            _buildNavItem(
              icon: Icons.list,
              label: '列表',
              index: 1,
              isSelected: _selectedIndex == 1,
            ),
            _buildNavItem(
              icon: Icons.person,
              label: '我的',
              index: 2,
              isSelected: _selectedIndex == 2,
            ),
          ],
        ),
      ),
    );
  }

  // 底部导航项
  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });

        // 这里可以添加页面切换逻辑
        if (index != 2) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('切换到$label页面'),
              duration: Duration(seconds: 1),
            ),
          );
        }
      },
      child: Container(
        width: 67,
        padding: EdgeInsets.symmetric(vertical: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 图标
            Container(
              padding: EdgeInsets.all(4),
              child: Icon(
                icon,
                size: 24,
                color: isSelected ? Color(0xFF777777) : Color(0xFFF6F5FA),
              ),
            ),

            // 标签
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? Color(0xFFF6F5FA) : Color(0xFF4A484D),
                fontFamily: 'PingFang SC',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
