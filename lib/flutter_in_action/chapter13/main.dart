import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../chapter11/FileOperationRoute.dart';
import '../chapter11/HttpTestRoute.dart';
/// Created by p_dmweidu on 2023/3/22
/// Desc: 第13章入口
///
class Chapter13HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第13章'),
      ),
      body: ListView(
        children: <Widget>[
          ElevatedButton(
            child: Text("文件操作"),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FileOperationRoute()));
            },
          ),
          ElevatedButton(
            child: Text(
              "通过HttpClient发起HTTP请求",
              style: new TextStyle(fontSize: 20, color: Colors.redAccent),
            ),
            onPressed: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) => HttpTestRoute()));
            },
          ),
        ],
      ),
    );
  }
}
