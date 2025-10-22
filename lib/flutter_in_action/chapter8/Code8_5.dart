import 'package:flutter/material.dart';
import 'dart:async';

///
/// Created by 杜明伟 on 2023/3/21.
/// 事件总线
class Code85 extends StatefulWidget {
  @override
  _Code85State createState() => new _Code85State();
}

class _Code85State extends State<Code85> {
  // 使用一个简单的 StreamController 作为本示例的事件总线
  final StreamController<String> _bus = StreamController<String>.broadcast();
  String _msg = '未收到事件';

  @override
  void initState() {
    super.initState();
    // 订阅事件
    _bus.stream.listen((event) {
      setState(() {
        _msg = event;
      });
    });
  }

  @override
  void dispose() {
    _bus.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('事件总线示例'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_msg),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                // 发送事件
                _bus.add('事件于 ${DateTime.now()} 发送');
              },
              child: Text('发送事件'),
            ),
          ],
        ),
      ),
    );
  }
}
