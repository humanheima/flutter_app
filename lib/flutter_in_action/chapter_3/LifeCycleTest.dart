import 'package:flutter/material.dart';

///
/// Created by dumingwei on 2019-10-20.
/// Desc: 测试State生命周期
///

class LifeCycleTest extends StatefulWidget {
  final int initValue;

  const LifeCycleTest({Key key, this.initValue});

  @override
  State createState() {
    return _LifeCycleTestState();
  }
}

class _LifeCycleTestState extends State<LifeCycleTest> {
  int _counter;

  String tag = "_LifeCycleTestState";

  @override
  void initState() {
    super.initState();
    print('$tag, initState');
    _counter = widget.initValue;
  }

  @override
  Widget build(BuildContext context) {
    print('$tag, build');
    return Scaffold(
      appBar: AppBar(
        title: Text('测试测试State生命周期'),
      ),
      body: Center(
        child: RaisedButton(
            child: Text('$_counter'),
            //点击后计数器自增
            onPressed: () => setState(() {
                  ++_counter;
                })),
      ),
    );
  }

  @override
  void didUpdateWidget(LifeCycleTest oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('$tag, didUpdateWidget');
  }

  @override
  void deactivate() {
    super.deactivate();
    print('$tag, deactivate');
  }

  @override
  void reassemble() {
    super.reassemble();
    print('$tag, reassemble');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('$tag, didChangeDependencies');
  }

  @override
  void dispose() {
    super.dispose();
    print('$tag, dispose');
  }
}
