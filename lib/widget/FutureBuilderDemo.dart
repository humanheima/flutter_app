import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

///
/// Created by dumingwei on 2025/12/02
/// Desc: 测试使用 FutureBuilder 组件展示异步数据
///
class FutureBuilderDemo extends StatefulWidget {

  @override
  _FutureBuilderDemoState createState() => _FutureBuilderDemoState();
}

class _FutureBuilderDemoState extends State<FutureBuilderDemo> {
  late Future<String> _future;

  @override
  void initState() {
    super.initState();
    _future = _fetchData();
  }

  Future<String> _fetchData() async {
    // 模拟网络延迟
    await Future.delayed(Duration(milliseconds: 800 + Random().nextInt(1200)));

    // 随机抛出错误以演示错误处理
    if (Random().nextDouble() < 0.5) {
      throw Exception('模拟网络错误，请重试');
    }

    // 返回模拟数据
    return '这是从远端获取到的数据（线程安全示例）\n时间：${DateTime.now()}';
  }

  void _retry() {
    setState(() {
      _future = _fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FutureBuilder 示例'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '演示：FutureBuilder 根据异步数据展示不同状态',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),

                  // FutureBuilder
                  FutureBuilder<String>(
                    future: _future,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Column(
                          children: [
                            SizedBox(height: 16),
                            CircularProgressIndicator(),
                            SizedBox(height: 12),
                            Text('正在加载中...'),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Column(
                          children: [
                            SizedBox(height: 16),
                            Icon(Icons.error_outline,
                                color: Colors.red, size: 40),
                            SizedBox(height: 12),
                            Text(
                              '发生错误：${snapshot.error}',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red[700]),
                            ),
                            SizedBox(height: 12),
                            ElevatedButton.icon(
                              onPressed: _retry,
                              icon: Icon(Icons.refresh),
                              label: Text('重试'),
                            ),
                          ],
                        );
                      } else if (snapshot.hasData) {
                        return Column(
                          children: [
                            SizedBox(height: 12),
                            Text(
                              snapshot.data!,
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16),
                            ElevatedButton.icon(
                              onPressed: _retry,
                              icon: Icon(Icons.refresh_outlined),
                              label: Text('重新加载'),
                            ),
                          ],
                        );
                      } else {
                        return Text('无数据');
                      }
                    },
                  ),
                  SizedBox(height: 8),

                  // 说明
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text(
                      '注意：这是一个本地模拟示例，实际使用中请将 Future 替换为真实的网络/IO 调用。',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
