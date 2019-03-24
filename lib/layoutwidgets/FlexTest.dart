import 'package:flutter/material.dart';

///
/// Crete by dumingwei on 2019/3/18
/// Desc:弹性布局 弹性布局允许子widget按照一定比例来分配父容器空间
///

class FlexLayoutTestRoute extends StatelessWidget {
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
            Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 30.0,
                    color: Colors.red,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 30.0,
                    color: Colors.green,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: SizedBox(
                height: 100.0,
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    Expanded(
                        flex: 2,
                        child: Container(
                          height: 30.0,
                          color: Colors.red,
                        )),
                    Spacer(
                      flex: 1,
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          height: 30.0,
                          color: Colors.green,
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
