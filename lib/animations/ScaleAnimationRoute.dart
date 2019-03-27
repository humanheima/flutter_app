import 'package:flutter/material.dart';

///
/// Crete by dumingwei on 2019/3/26
/// Desc: 感觉动画效果有点奇怪,为什么会有一个竖直方向上向下的移动过程呢？
///

class ScaleAnimationRoute extends StatefulWidget {
  @override
  State createState() {
    return _ScaleAnimationRouteState();
  }
}

///需要继承TickerProvider，如果有多个AnimationController，则应该使用TickerProviderStateMixin。
class _ScaleAnimationRouteState extends State<ScaleAnimationRoute>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        new AnimationController(vsync: this, duration: Duration(seconds: 3));
    //图片宽高从0变到300
    /*//使用弹性曲线
    animation = new Tween(begin: 0.0, end: 500.0).animate(
        new CurvedAnimation(parent: controller, curve: Curves.bounceIn))
      ..addListener(() {
        setState(() {});
      });*/

    animation = new Tween(begin: 0.0, end: 300.0).animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          //动画执行结束时反向执行动画
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          //动画恢复到初始状态时执行动画（正向）
          controller.forward();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            width: 100.0,
            height: 100.0,
            child: null,
          ),
          Container(
            /*child: AnimatedImage(
              animation: animation,
            ),*/
            child: GrowTransition(
              child: Image.asset("images/avatar.png"),
              animation: animation,
            ),
          ),
          RaisedButton(
            child: Text(
              "开启动画",
              style: new TextStyle(fontSize: 20, color: Colors.redAccent),
            ),
            onPressed: () {
              controller.forward();
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

///使用AnimatedWidget
class AnimatedImage extends AnimatedWidget {
  AnimatedImage({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return new Center(
      child: Image.asset("images/avatar.png",
          width: animation.value, height: animation.value),
    );
  }
}

///使用AnimatedBuilder来封装动画
class GrowTransition extends StatelessWidget {
  GrowTransition({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;

  Widget build(BuildContext context) {
    return new Container(
      child: new AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget child) {
            return new Container(
                alignment: Alignment.topCenter,
                height: animation.value,
                width: animation.value,
                child: child);
          },
          child: child),
    );
  }
}
