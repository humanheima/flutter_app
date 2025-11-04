import 'package:flutter/material.dart';
import 'CounterWidget.dart';

///
/// 测试State的生命周期
///
class StateLifecycleTest extends StatelessWidget {
  const StateLifecycleTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: AppBar(
        title: Text("测试State的生命周期"),
      ),
      body: CounterWidget(key: Key(""), initialValue: 0),
      //body: Text("xxx"),
    );
  }
}
