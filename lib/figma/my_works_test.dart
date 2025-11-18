import 'package:flutter/material.dart';
import 'package:flutter_app/figma/my_works_page.dart';

/// 测试我的作品页面的独立入口
void main() {
  runApp(const MyWorksApp());
}

class MyWorksApp extends StatelessWidget {
  const MyWorksApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '我的作品',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyWorksPage(),
    );
  }
}
