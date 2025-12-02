import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GrowingTextDemo extends StatefulWidget {
  @override
  State<GrowingTextDemo> createState() => _GrowingTextDemoState();
}

class _GrowingTextDemoState extends State<GrowingTextDemo> {
  String _message = "开始只有一行";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("文字自动撑开动画")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 重点代码段
            AnimatedSize(
              duration: Duration(milliseconds: 400),
              curve: Curves.easeOutCubic,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  _message,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),

            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _message += "\n这是一段新添加的内容，演示自动换行和高度动画效果～";
                });
              },
              child: Text("追加一段文字"),
            ),
          ],
        ),
      ),
    );
  }
}