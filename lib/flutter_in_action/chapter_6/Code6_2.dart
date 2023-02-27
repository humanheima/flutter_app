import 'package:flutter/material.dart';

///
/// Created by dumingwei on 2019-10-08.
/// Desc:SingleChildScrollView类似于Android中的ScrollView，它只能接收一个子组件
///
class SingleChildScrollViewTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

    return new Scaffold(
      appBar: new AppBar(
          title: new Text(
        "SingleChildScrollView",
      )),
      backgroundColor: Colors.white,
      body: Container(
        child: Scrollbar(
            child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: str
                  .split("")
                  .map((c) => Text(
                        c,
                        textScaleFactor: 2.0,
                      ))
                  .toList(),
            ),
          ),
        )),
      ),
    );
  }
}
