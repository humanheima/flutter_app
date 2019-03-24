import 'package:flutter/material.dart';

///
/// Crete by dumingwei on 2019/3/18
/// Desc:流式布局
///

class WrapFlowTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text(
        "布局类Widgets",
      )),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: <Widget>[
            //Flex的两个子widget按1：2来占据水平空间

            Wrap(
              spacing: 8.0,
              runSpacing: 4.0, // 纵轴（垂直）方向间距
              alignment: WrapAlignment.center,
              children: <Widget>[
                new Chip(
                  label: new Text("Hamilton"),
                  avatar: new CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text('A'),
                  ),
                ),
                new Chip(
                  label: new Text("Lafayette"),
                  avatar: new CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text('M'),
                  ),
                ),
                new Chip(
                  label: new Text("Mulligan"),
                  avatar: new CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text('H'),
                  ),
                ),
                new Chip(
                  label: new Text("Laurens"),
                  avatar: new CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text('J'),
                  ),
                ),
              ],
            ),
            Flow(
              delegate: TestFlowDelegate(margin: EdgeInsets.all(10.0)),
              children: <Widget>[
                new Container(
                  width: 80.0,
                  height: 80.0,
                  color: Colors.red,
                ),
                new Container(
                  width: 80.0,
                  height: 80.0,
                  color: Colors.green,
                ),
                new Container(
                  width: 80.0,
                  height: 80.0,
                  color: Colors.blue,
                ),
                new Container(
                  width: 80.0,
                  height: 80.0,
                  color: Colors.yellow,
                ),
                new Container(
                  width: 80.0,
                  height: 80.0,
                  color: Colors.brown,
                ),
                new Container(
                  width: 80.0,
                  height: 80.0,
                  color: Colors.purple,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TestFlowDelegate extends FlowDelegate {
  EdgeInsets margin = EdgeInsets.zero;

  TestFlowDelegate({this.margin});

  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin.left;
    var y = margin.top;
    //计算每一个子widget的位置
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i).width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i).height + margin.top + margin.bottom;
        //绘制子widget(有优化)
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x += context.getChildSize(i).width + margin.left + margin.right;
      }
    }
  }

  getSize(BoxConstraints constraints) {
    //指定Flow的大小
    return Size(double.infinity, 200.0);
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}
