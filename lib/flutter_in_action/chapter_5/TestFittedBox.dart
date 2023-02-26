import 'package:flutter/material.dart';
import 'package:flutter_app/flutter_in_action/LayoutParamsLog.dart';

///
/// Created by 杜明伟 on 2023/2/25.
/// 空间适配，子组件如何适配父组件空间？
///

class TestFittedBox extends StatelessWidget {
  TestFittedBox();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('空间适配（FittedBox'),
      ),
      //body: getWidget(),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30.0),
            child: Row(
              children: [Text('文字过长，宽度溢出' * 30)],
            ),
          ),
          //getWidget2()
          getWidget3()
        ],
      ),
    );
  }

  Widget getWidget() {
    return Column(
      children: [
        wContainer(BoxFit.none),
        Text('Wendux'),
        wContainer(BoxFit.contain),
        Text('Flutter中国'),
      ],
    );
  }

  Widget getWidget2() {
    return Column(
      children: [
        wRow(' 90000000000000000 '),
        FittedBox(child: wRow(' 90000000000000000 ')),
        //wRow(' 800 '),
        LayoutParamsLog(
          tag: "TestFittedBox1",
          child: wRow(' 800 '),
        ),
        FittedBox(
            child: LayoutParamsLog(
          tag: "TestFittedBox2",
          child: wRow(' 800 '),
        )),
      ]
          .map((e) => Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: e,
              ))
          .toList(),
    );
  }

  Widget getWidget3() {
    return Column(
      children: [
        wRow(' 90000000000000000 '),
        new SingleLineFittedBox(child: wRow(' 90000000000000000 ')),
        wRow(' 800 '),
        SingleLineFittedBox(child: wRow(' 800 ')),
      ]
          .map((e) => Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: e,
              ))
          .toList(),
    );
  }

  List<Widget> getWidgetList() {
    return Column(
      children: [
        wRow(' 90000000000000000 '),
        FittedBox(child: wRow(' 90000000000000000 ')),
        wRow(' 800 '),
        FittedBox(child: wRow(' 800 ')),
      ]
          .map((e) => Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: e,
              ))
          .toList(),
    ).children;
  }

  Widget wContainer(BoxFit boxFit) {
    return Container(
      width: 50,
      height: 50,
      color: Colors.red,
      child: FittedBox(
        fit: boxFit,
        child: Container(
          // 子容器超过父容器大小
          width: 60,
          height: 70,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget wRow(String text) {
    Widget textChild = Text(
      text,
      style: TextStyle(fontSize: 20),
    );
    Widget child = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [textChild, textChild, textChild],
    );
    return child;
  }
}

class SingleLineFittedBox extends StatelessWidget {
  final Widget child;

  const SingleLineFittedBox({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      return FittedBox(
        child: ConstrainedBox(
          constraints: constraints.copyWith(
              maxWidth: double.infinity, minWidth: constraints.maxWidth),
          child: child,
        ),
      );
    });
  }
}
