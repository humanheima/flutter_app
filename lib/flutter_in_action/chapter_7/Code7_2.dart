import 'package:flutter/material.dart';

///
/// Crete by dumingwei on 2019/3/24
/// Desc: InheritedWidget
///
/// InheritedWidget是Flutter中非常重要的一个功能型Widget，
/// 它可以高效的将数据在Widget树中向下传递、共享，
/// 这在一些需要在Widget树中共享数据的场景中非常方便，如Flutter中， 正是通过InheritedWidget来共享应用主题(Theme)和Locale(当前语言环境)信息的。

class InheritedWidgetRoute extends StatefulWidget {
  @override
  State createState() {
    return _InheritedWidgetRouteState();
  }
}

class _InheritedWidgetRouteState extends State<InheritedWidgetRoute> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
          child: ShareDataWidget(
        data: count,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: TestWidget(),
            ),
            RaisedButton(
              child: Text("Increment"),
              onPressed: () => setState(() => ++count),
            )
          ],
        ),
      )),
    );
  }
}

class ShareDataWidget extends InheritedWidget {
  final int data; //需要在子树中共享的数据，保存点击次数

  ShareDataWidget({@required this.data, Widget child}) : super(child: child);

  ///定义一个便捷方法，方便子树中的widget获取共享数据
  static ShareDataWidget of(BuildContext context) {
    /*return context.inheritFromWidgetOfExactType(ShareDataWidget)
        as ShareDataWidget;*/
    return context
        .getElementForInheritedWidgetOfExactType<ShareDataWidget>()
        .widget;
  }

  //该回调决定当data发生变化时，是否通知子树中依赖data的Widget
  @override
  bool updateShouldNotify(ShareDataWidget oldWidget) {
    return oldWidget.data != data;
  }
}

class TestWidget extends StatefulWidget {
  @override
  _TestWidgetState createState() => new _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(ShareDataWidget.of(context).data.toString());
    //return Text('text');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //父或祖先widget中的InheritedWidget改变(updateShouldNotify返回true)时会被调用。
    //如果build中没有依赖InheritedWidget，则此回调不会被调用。
    print('Dependencies change');
  }
}
