import 'package:flutter/material.dart';

///
/// Created by 杜明伟 on 2023/2/26.
///

class LayoutParamsLog<T> extends StatelessWidget {
  const LayoutParamsLog({
    Key key,
    this.tag,
    @required this.child,
  }) : super(key: key);

  final Widget child;
  final T tag; //指定日志tag

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      // assert在编译release版本时会被去除
      assert(() {
        print('${tag ?? key ?? child}: $constraints');
        return true;
      }());
      return child;
    });
  }
}
