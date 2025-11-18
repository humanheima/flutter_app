import 'package:flutter/material.dart';
import 'dio_proxy_demo.dart';

/// 快速启动入口
///
/// 使用方法：
/// 1. 直接运行此文件：flutter run lib/proxy/proxy_demo_main.dart
/// 2. 或在 main.dart 中导入 DioProxyDemo 组件使用
void main() {
  runApp(const ProxyDemoApp());
}

class ProxyDemoApp extends StatelessWidget {
  const ProxyDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dio Proxy Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const DioProxyDemo(),
    );
  }
}
