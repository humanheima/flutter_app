import 'package:flutter/material.dart';
import 'package:flutter_app/navigation_utils.dart';

void main() => runApp(ReturnValueDemoApp());

class ReturnValueDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '返回值 Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _lastResult = '尚未收到返回值';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('首页 - 等待返回值')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_lastResult),
            SizedBox(height: 16),
            ElevatedButton(
              child: Text('打开页面并等待返回值'),
              onPressed: () async {
                // 使用 NavigationUtils.pushFade 跳转并等待返回值
                final result = await NavigationUtils.pushFade<String?>(
                  context,
                  SecondPage(),
                );

                // 更新 UI
                setState(() {
                  _lastResult = result == null ? '返回了 null' : '收到：$result';
                });

                // 也展示一个 SnackBar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('toast 返回值：${result ?? 'null'}')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 使用 WillPopScope 捕获物理返回键
    return WillPopScope(
      onWillPop: () async {
        // 在这里可以决定返回什么值
        Navigator.pop(context, '通过物理返回键返回的值');
        // 返回 false 阻止框架再次 pop（因为我们手动 pop 了）
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('第二页 - 返回一个值'),
          // 自定义 AppBar 的返回按钮，使其返回一个值
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context, '通过 AppBar 返回的值');
            },
          ),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('在此页面按返回将返回一个字符串给上一页'),
              SizedBox(height: 16),
              ElevatedButton(
                child: Text('返回：确认'),
                onPressed: () {
                  Navigator.pop(context, '通过按钮返回的值');
                },
              ),
              SizedBox(height: 8),
              ElevatedButton(
                child: Text('返回：取消'),
                onPressed: () {
                  Navigator.pop(context, '通过按钮返回的取消');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
