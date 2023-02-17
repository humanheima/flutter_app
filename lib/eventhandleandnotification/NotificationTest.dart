import 'package:flutter/material.dart';

///
/// Crete by dumingwei on 2019/3/25
/// Desc: 通知Notification是Flutter中一个重要的机制，在Widget树中，每一个节点都可以分发通知，
/// 通知会沿着当前节点（context）向上传递，所有父节点都可以通过NotificationListener来监听通知，
/// Flutter中称这种通知由子向父的传递为“通知冒泡”（Notification Bubbling），
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
      body: NotificationListener<MyNotification>(
        onNotification: (notification) {
          setState(() {
            msg += notification.msg + " ";
          });
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Builder(
                builder: (context) {
                  return ElevatedButton(
                    //分发通知
                    onPressed: () => MyNotification("Hi").dispatch(context),
                    child: Text("Send Notification"),
                  );
                },
              ),
              Text(msg),
            ],
          ),
        ),
      ),
    );
  }
}

class MyNotification extends Notification {
  final String msg;

  MyNotification(this.msg);
}
