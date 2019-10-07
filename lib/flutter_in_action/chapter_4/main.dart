import 'package:flutter/material.dart';

import 'Code4_2.dart';
import 'Code4_3.dart';
import 'Code4_4.dart';
import 'Code4_5.dart';
import 'Code4_6.dart';

///
/// Created by dumingwei on 2019-10-07.
/// Desc: Flutter中通过Wrap和Flow来支持流式布局
///

class Chapter4HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第4章'),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            RaisedButton(
                child: Text('4.2：线性布局（Row、Column）'),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) {
                    return new RowColumnWidget();
                  }));
                }),
            RaisedButton(
                child: Text('4.3 弹性布局（Flex）'),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) {
                    return new FlexLayoutTestRoute();
                  }));
                }),
            RaisedButton(
                child: Text('4.4 流式布局'),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) {
                    return new WrapFlowTestRoute();
                  }));
                }),
            RaisedButton(
                child: Text('4.5 层叠布局 Stack、Positioned'),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) {
                    return new StackPositionedRoute();
                  }));
                }),
            RaisedButton(
                child: Text('4.6 对齐与相对定位（Align）'),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) {
                    return new AlignTestRoute();
                  }));
                }),
          ],
        ),
      ),
    );
  }
}
