import 'package:flutter/material.dart';

import 'Code5_1.dart';
import 'Code5_2.dart';
import 'Code5_3.dart';
import 'Code5_4.dart';
import 'Code5_5.dart';
import 'Code5_6.dart';
import 'Code5_7.dart';

///
/// Created by dumingwei on 2019-10-07.
/// Desc: Flutter中通过Wrap和Flow来支持流式布局
///

class Chapter5HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第5章'),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            ElevatedButton(
              child: Text(
                "5.1 填充（Padding）",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return PaddingTestRoute();
                }));
              },
            ),
            ElevatedButton(
                child: Text('5.2 尺寸限制类容器'),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) {
                    return new ConstrainedWidgetTestRoute();
                  }));
                }),
            ElevatedButton(
                child: Text('5.3 装饰容器DecoratedBox'),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) {
                    return new DecoratedWidgetRoute();
                  }));
                }),
            ElevatedButton(
                child: Text('5.4 变换（Transform）'),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) {
                    return new TransformTestRoute();
                  }));
                }),
            ElevatedButton(
                child: Text('5.5 Container'),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) {
                    return new ContainerTestRoute();
                  }));
                }),
            ElevatedButton(
                child: Text('5.6 Scaffold、TabBar、底部导航'),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) {
                    return new ScaffoldRoute();
                  }));
                }),
            ElevatedButton(
                child: Text('5.7 剪裁（Clip）'),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) {
                    return new ClipTestRoute();
                  }));
                }),
          ],
        ),
      ),
    );
  }
}
