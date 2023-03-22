import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'FileOperationRoute.dart';
import 'HttpTestRoute.dart';
/// Created by p_dmweidu on 2023/3/22
/// Desc: 第11章入口
///
class Chapter11HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第11章'),
      ),
      body: ListView(
        children: <Widget>[
          ElevatedButton(
            child: Text("文件操作"),
            onPressed: () {
              Navigator.push(context, new MaterialPageRoute(builder: (context) {
                return FileOperationRoute();
              }));
            },
          ),
          ElevatedButton(
            child: Text(
              "通过HttpClient发起HTTP请求",
              style: new TextStyle(fontSize: 20, color: Colors.redAccent),
            ),
            onPressed: () {
              Navigator.push(context,
                  new CupertinoPageRoute(builder: (context) {
                    return HttpTestRoute();
                  }));
            },
          ),
        ],
      ),
    );
  }
}
