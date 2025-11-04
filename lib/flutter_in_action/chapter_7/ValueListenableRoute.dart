import 'package:flutter/material.dart';

///
/// Created by 杜明伟 on 2023/3/21.
/// 7.5 按需rebuild（ValueListenableBuilder）

class ValueListenableRoute extends StatefulWidget {
  const ValueListenableRoute({Key? key}) : super(key: key);

  @override
  _ValueListenableRouteState createState() => new _ValueListenableRouteState();
}

class _ValueListenableRouteState extends State<ValueListenableRoute> {
  // 定义一个ValueNotifier，当数字变化时会通知 ValueListenableBuilder
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);

  static const double textScaleFactor = 1.5;

  @override
  Widget build(BuildContext context) {
    print("ValueListenableRouteState 只build一次");

    return Scaffold(
      appBar: AppBar(
        title: Text('ValueListenableBuilder 测试'),
      ),
      body: Center(
        child: ValueListenableBuilder<int>(
          valueListenable: _counter,
          builder: (BuildContext context, int value, Widget? child) {
            // builder 方法只会在 _counter 变化时被调用
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (child != null) child,
                Text(
                  '$value 次',
                  textScaler: TextScaler.linear(textScaleFactor),
                )
              ],
            );
          },
          // 当子组件不依赖变化的数据，且子组件收件开销比较大时，指定 child 属性来缓存子组件非常有用
          child: const Text(
            '点击了 ',
            textScaler: TextScaler.linear(1.5),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _counter.value += 1,
      ),
    );
  }
}
