import 'package:flutter/material.dart';

///
/// Crete by dumingwei on 2019/3/19
/// Desc:  ConstrainedBox和SizedBox,UnconstrainedBox，
///

class ConstrainedWidgetTestRoute extends StatelessWidget {
  final Widget redBox =
      DecoratedBox(decoration: BoxDecoration(color: Colors.red));
  final Widget greenBox =
      DecoratedBox(decoration: BoxDecoration(color: Colors.green));

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("5.2 尺寸限制类容器"),
      ),
      body: Padding(
        //上下左右各添加16像素补白
        padding: EdgeInsets.all(16.0),
        child: Column(
          //显式指定对齐方式为左对齐
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ConstrainedBox(
                child: Container(
                  height: 5.0,
                  child: redBox,
                ),
                constraints:
                    BoxConstraints(minWidth: double.infinity, minHeight: 50.0)),
            SizedBox(width: 80.0, height: 80.0, child: greenBox),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            ConstrainedBox(
                child: redBox,
                constraints:
                    BoxConstraints.tightFor(width: 80.0, height: 80.0)),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            ConstrainedBox(
              //父
              constraints: BoxConstraints(minWidth: 60.0, minHeight: 60.0),

              child: ConstrainedBox(
                constraints:
                    BoxConstraints(minWidth: 90.0, minHeight: 20.0), //子
                child: redBox,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(minWidth: 60.0, minHeight: 60.0),
              child: UnconstrainedBox(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: 90.0, minHeight: 20.0),
                  child: redBox,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(minWidth: 100, maxHeight: 100),
              child: AspectRatio(
                aspectRatio: 16.0 / 9.0,
                child: Container(
                  color: Colors.grey,
                  child: Image(
                    fit: BoxFit.contain,
                    image: AssetImage("images/avatar.jpg"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
