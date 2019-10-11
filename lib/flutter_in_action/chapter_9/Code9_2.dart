import 'package:flutter/material.dart';

///
/// Crete by dumingwei on 2019/3/26
///

class ScaleAnimationRoute extends StatefulWidget {
  @override
  _ScaleAnimationRouteState createState() {
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
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });

    //使用弹性曲线
    /*animation = new Tween(begin: 0.0, end: 500.0).animate(
        new CurvedAnimation(parent: controller, curve: Curves.bounceIn))
      ..addListener(() {
        setState(() {});
      });*/
    //controller.forward();

    /*animation = new Tween(begin: 0.0, end: 300.0).animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          //动画执行结束时反向执行动画
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          //动画恢复到初始状态时执行动画（正向）
          controller.forward();
        }
      });*/
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('9.2 动画基本结构及状态监听'),
      ),
      //body: buildSample1(),
      //body: getAnimatedImage(),
      //body: getGrowTransition(),
      body: repeatAnimation(),
    );
  }

  Column buildSample1() {
    return new Column(
      children: <Widget>[
        Container(
          child: new Center(
            child: Image.asset(
              "images/avatar.jpg",
              width: animation.value,
              height: animation.value,
            ),
          ),
          margin: EdgeInsets.only(top: 20.0),
        ),
        RaisedButton(
          child: Text(
            "开启动画",
          ),
          onPressed: () {
            controller.forward();
          },
        ),
      ],
    );
  }

  Column getAnimatedImage() {
    return Column(
      children: <Widget>[
        Container(
          child: AnimatedImage(
            animation: animation,
          ),
          /*child: GrowTransition(
            child: Image.asset("images/avatar.png"),
            animation: animation,
          ),*/
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
    );
  }

  Column getGrowTransition() {
    return Column(
      children: <Widget>[
        Container(
          child: GrowTransition(
            child: Image.asset("images/avatar.jpg"),
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
    );
  }

  Column repeatAnimation() {
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    return Column(
      children: <Widget>[
        Container(
          child: GrowTransition(
            child: Image.asset("images/avatar.jpg"),
            animation: animation,
          ),
        ),
        RaisedButton(
          child: Text(
            "开启动画",
          ),
          onPressed: () {
            controller.forward();
          },
        ),
      ],
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
      child: Image.asset("images/bg_dark.png",
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
    return new Center(
      child: new AnimatedBuilder(
        animation: animation,
        child: child,
        builder: (BuildContext context, Widget child) {
          return new Container(
              height: animation.value, width: animation.value, child: child);
        },
      ),
    );
  }
}
