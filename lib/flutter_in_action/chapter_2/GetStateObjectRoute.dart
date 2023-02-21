import 'package:flutter/material.dart';

///
/// Created by 杜明伟 on 2023/2/20.
/// 测试在 widget 树中获取State对象
///

class GetStateObjectRoute extends StatefulWidget {
  GetStateObjectRoute({Key key}) : super(key: key);

  @override
  _GetStateObjectRouteState createState() => new _GetStateObjectRouteState();
}

class _GetStateObjectRouteState extends State<GetStateObjectRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("子树中获取State对象"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  // 查找父级最近的Scaffold对应的ScaffoldState对象
                  // ScaffoldState _state =
                  //     context.findAncestorStateOfType<ScaffoldState>();
                  ScaffoldState _state = Scaffold.of(context);
                  // 打开抽屉菜单
                  _state.openDrawer();
                },
                child: Text('打开抽屉菜单1')),
            ElevatedButton(
                onPressed: () {
                  // 查找父级最近的Scaffold对应的ScaffoldState对象
                  // ScaffoldState _state =
                  //     context.findAncestorStateOfType<ScaffoldState>();
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("我是SnackBar")));
                },
                child: Text('显示SnackBar'))
          ],
        ),
      ),
      drawer: Drawer(),
    );
  }
}
