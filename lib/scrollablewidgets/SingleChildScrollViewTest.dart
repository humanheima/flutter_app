import 'package:flutter/material.dart';

///
/// Crete by dumingwei on 2019/3/24
/// Desc: SingleChildScrollView类似于Android中的ScrollView，它只能接收一个子Widget。
///

class SingleChildScrollViewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

    return new Scaffold(
      appBar: new AppBar(
          title: new Text(
        "布局类Widgets",
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
