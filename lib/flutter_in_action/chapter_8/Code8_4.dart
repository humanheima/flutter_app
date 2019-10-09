import 'package:flutter/material.dart';

///
/// Crete by dumingwei on 2019/3/25
/// Desc: 通知Notification是Flutter中一个重要的机制，在Widget树中，每一个节点都可以分发通知，
/// 通知会沿着当前节点（context）向上传递，所有父节点都可以通过NotificationListener来监听通知，
/// Flutter中称这种通知由子向父的传递为“通知冒泡”（Notification Bubbling）。
///

class NotificationRoute extends StatefulWidget {
  @override
  State createState() {
    return new NotificationRouteState();
  }
}

class NotificationRouteState extends State<NotificationRoute> {
  String msg = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('8.4 Notification'),
      ),
      body: Column(
        children: <Widget>[
          Container(
              height: 200.0,
              child: NotificationListener<Notification>(
                onNotification: (notification) {
                  switch (notification.runtimeType) {
                    case ScrollStartNotification:
                      print('开始滚动');
                      break;
                    case ScrollUpdateNotification:
                      print("正在滚动");
                      break;
                    case ScrollEndNotification:
                      print("滚动停止");
                      break;
                    case OverscrollNotification:
                      print("滚动到边界");
                      break;
                  }
                  return false;
                },
                child: ListView.builder(
                    itemCount: 100,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('$index'),
                      );
                    }),
              )),
          Container(
            child: NotificationListener<MyNotification>(
                onNotification: (notification) {
                  print("父节点收到通知：" + notification.msg); //打印通知
                  return false;
                },
                child: NotificationListener<MyNotification>(
                    onNotification: (notification) {
                      setState(() {
                        msg += notification.msg + " ";
                      });
                      return true;
                    },
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Builder(builder: (context) {
                            return RaisedButton(
                                child: Text('发送自定义通知'),
                                onPressed: () {
                                  MyNotification("Hi").dispatch(context);
                                });
                          }),
                          Text(msg),
                        ],
                      ),
                    ))),
          )
        ],
      ),
    );
  }
}

class MyNotification extends Notification {
  final String msg;

  MyNotification(this.msg);
}
