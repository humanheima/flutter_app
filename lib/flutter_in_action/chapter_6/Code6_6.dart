import 'package:flutter/material.dart';

///
/// Created by dumingwei on 2019-10-08.
/// Desc:
///
class ScrollControllerTestRoute extends StatefulWidget {
  @override
  State createState() {
    return new ScrollControllerTestRouteState();
  }
}

class ScrollControllerTestRouteState extends State<ScrollControllerTestRoute> {
  ScrollController _controller = new ScrollController();

  bool showToTopBtn = false; //是否显示“返回到顶部”按钮

  @override
  void initState() {
    super.initState();
    //监听滚动事件，打印滚动位置
    _controller.addListener(() {
      print(_controller.offset);
      if (_controller.offset < 1000 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('6.6 滚动监听及控制'),
      ),
      body: Scrollbar(
          child: ListView.builder(
              itemCount: 100,
              controller: _controller,
              itemExtent: 50.0,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('$index'),
                );
              })),
      floatingActionButton: !showToTopBtn
          ? null
          : FloatingActionButton(
              child: Icon(Icons.arrow_upward),
              onPressed: () {
                _controller.animateTo(0.0,
                    duration: Duration(microseconds: 200), curve: Curves.ease);
              },
            ),
    );
  }

  @override
  void dispose() {
    //为了避免内存泄露，需要调用_controller.dispose
    _controller.dispose();
    super.dispose();
  }
}

///NotificationListener 监听滚动事件
class ScrollNotificationTestRoute extends StatefulWidget {
  @override
  State createState() {
    return _ScrollNotificationTestRouteState();
  }
}

class _ScrollNotificationTestRouteState
    extends State<ScrollNotificationTestRoute> {
  String _progress = "0%";

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scrollbar(
          // 监听滚动通知
          child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          double progress = notification.metrics.pixels /
              notification.metrics.maxScrollExtent;
          setState(() {
            _progress = "${(progress * 100).toInt()}%";
          });
          //是否滚到到了底部
          print("BottomEdge: ${notification.metrics.extentAfter == 0}");
          return true;
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ListView.builder(
                itemExtent: 50.0,
                itemCount: 100,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("$index"),
                  );
                }),
            CircleAvatar(
              radius: 30.0,
              child: Text(_progress),
              backgroundColor: Colors.black54,
            )
          ],
        ),
      )),
    );
  }
}
