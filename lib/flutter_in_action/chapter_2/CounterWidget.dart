import 'package:flutter/material.dart';

///
/// Created by dumingwei on 2019-09-30.
/// Desc:
///

class CounterWidget extends StatefulWidget {
  final initialValue;

  const CounterWidget({Key key, this.initialValue});

  @override
  State createState() => new _CounterWidgetState();
}

///关于State的生命周期,计数器的功能
class _CounterWidgetState extends State<CounterWidget> {
  final String TAG = "_CounterWidgetState";

  int _counter;

  @override
  void initState() {
    super.initState();
    _counter = widget.initialValue;
    print("$TAG initState value is$_counter");
  }

  @override
  Widget build(BuildContext context) {
    print("$TAG build");
    return Center(
        child: new Container(
      color: Colors.white,
      child: new TextButton(
          //调用setState方法，会导致框架重新调用build方法
          onPressed: () => setState(() => ++_counter),
          child: Text('$_counter')),
    ));
  }

  @override
  void didUpdateWidget(CounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("$TAG didUpdateWidget");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("$TAG deactivate");
  }

  @override
  void dispose() {
    super.dispose();
    print("$TAG dispose");
  }

  @override
  void reassemble() {
    super.reassemble();
    print("$TAG reassemble");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("$TAG didChangeDependencies");
  }
}
