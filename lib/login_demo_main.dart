import 'package:flutter/material.dart';
import 'package:flutter_app/login_page.dart';
import 'package:flutter_app/profile_page.dart';

void main() {
  runApp(LoginDemoApp());
}

class LoginDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Figma登录页面演示',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginDemoHome(),
    );
  }
}

class LoginDemoHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Figma设计稿演示'),
        backgroundColor: Color(0xFF976FF5),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Figma登录页面演示',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              '这是根据您提供的Figma设计稿\n创建的Flutter登录页面',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text(
                '查看登录页面',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF976FF5),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
              child: Text(
                '查看个人资料页面',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF45B7D1),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '功能特点：',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  _buildFeatureItem('✓ 深色主题设计'),
                  _buildFeatureItem('✓ 手机号输入框（带区号选择）'),
                  _buildFeatureItem('✓ 短信验证码输入框'),
                  _buildFeatureItem('✓ 获取验证码倒计时功能'),
                  _buildFeatureItem('✓ 登录按钮状态控制'),
                  _buildFeatureItem('✓ 协议条款复选框'),
                  _buildFeatureItem('✓ 完全还原Figma设计'),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xFF45B7D1).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(0xFF45B7D1), width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '个人资料页面特点：',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF45B7D1)),
                  ),
                  SizedBox(height: 8),
                  _buildFeatureItem('✓ 自定义设备状态栏（信号、WiFi、电池）'),
                  _buildFeatureItem('✓ 用户头像和信息展示'),
                  _buildFeatureItem('✓ 账户余额卡片'),
                  _buildFeatureItem('✓ 创作者中心功能区'),
                  _buildFeatureItem('✓ 浮动底部导航栏'),
                  _buildFeatureItem('✓ 深色主题UI设计'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Text(
        text,
        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
      ),
    );
  }
}
