import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

///
/// Crete by dumingwei on 2019/3/25
/// Desc: 手势识别GestureDetector
///

class GestureDetectorTestRoute extends StatefulWidget {
  @override
  State createState() => GestureConflictTestRouteState();
}

/// 点击，双击，长按事件
class _GestureDetectorTestRouteState extends State<GestureDetectorTestRoute> {
  String _operation = "No Gesture detected!"; //保存事件名

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Center(
      child: new GestureDetector(
        child: Container(
          alignment: Alignment.center,
          color: Colors.blue,
          width: 200.0,
          height: 100.0,
          child: Text(
            _operation,
            style: TextStyle(color: Colors.white),
          ),
        ),
        onTap: () => updateText("Tap"),
        onDoubleTap: () => updateText("DoubleTap"),
        onLongPress: () => updateText("LongPress"),
      ),
    ));
  }

  void updateText(String text) {
    setState(() {
      _operation = text;
    });
  }
}

///拖动、滑动
class Drag extends StatefulWidget {
  @override
  State createState() {
    return new _DragState();
  }
}

class _DragState extends State<Drag> {
  double _top = 100.0; //距顶部的偏移
  double _left = 100.0; //距左边的偏移

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: _top,
            left: _left,
            child: GestureDetector(
              child: CircleAvatar(
                child: Text('A'),
              ),
              //手指按下时会触发此回调
              onPanDown: (DragDownDetails details) {
                //打印手指按下的位置(相对于屏幕)
                print("用户手指按下：${details.globalPosition}");
              },
              //手指滑动时会触发此回调
              onPanUpdate: (DragUpdateDetails details) {
                //用户手指滑动时，更新偏移，重新构建
                setState(() {
                  //_left += details.delta.dx;

                  //只改变竖直方向上的偏移量
                  _top += details.delta.dy;
                });
              },
              onPanEnd: (DragEndDetails details) {
                //打印滑动结束时在x、y轴上的速度
                print(details.velocity);
              },
            ),
          )
        ],
      ),
    );
  }
}

/// 缩放,好像不起作用啊
///
class _ScaleTestRouteState extends State<GestureDetectorTestRoute> {
  double _width = 200.0; //通过修改图片宽度来达到缩放效果

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        //指定宽度，高度自适应
        child: Image.asset("images/avatar.png", width: _width),
        onScaleUpdate: (ScaleUpdateDetails details) {
          setState(() {
            //缩放倍数在0.8到10倍之间
            _width = 200 * details.scale.clamp(0.8, 10.0);
          });
        },
      ),
    );
  }
}

///TapGestureRecognizer
class _GestureRecognizerTestRouteState extends State<GestureDetectorTestRoute> {
  TapGestureRecognizer _tapGestureRecognizer = new TapGestureRecognizer();
  bool _toggle = false;

  @override
  void dispose() {
    ///使用GestureRecognizer后一定要调用其dispose()方法来释放资源（主要是取消内部的计时器）。
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Text.rich(TextSpan(
          children: [
            TextSpan(text: "你好世界"),
            TextSpan(
                text: "点我变色",
                style: TextStyle(
                    fontSize: 30.0, color: _toggle ? Colors.blue : Colors.red),
                recognizer: _tapGestureRecognizer
                  ..onTap = () {
                    setState(() {
                      _toggle = !_toggle;
                    });
                  }),
            TextSpan(text: "你好世界"),
          ],
        )),
      ),
    );
  }
}

///手势竞争，只会有一个方向上的移动
class BothDirectionTestRouteState extends State<GestureDetectorTestRoute> {
  double _top = 100.0;
  double _left = 100.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            left: _left,
            top: _top,
            child: GestureDetector(
              child: CircleAvatar(
                child: Text('A'),
              ),
              onVerticalDragUpdate: (DragUpdateDetails details) {
                setState(() {
                  _top += details.delta.dy;
                });
              },
              onHorizontalDragUpdate: (DragUpdateDetails details) {
                setState(() {
                  _left += details.delta.dx;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}

///手势冲突
class GestureConflictTestRouteState extends State<GestureDetectorTestRoute> {
  double _left = 100.0;
  double _leftB = 200.0;
  double _top = 100.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 80.0,
            left: _leftB,
            child: Listener(
              onPointerDown: (details) {
                print("down");
              },
              onPointerUp: (details) {
                //会触发
                print("up");
              },
              child: GestureDetector(
                child: CircleAvatar(child: Text("B")),
                onHorizontalDragUpdate: (DragUpdateDetails details) {
                  setState(() {
                    _leftB += details.delta.dx;
                  });
                },
                onHorizontalDragEnd: (details) {
                  print("B onHorizontalDragEnd");
                },
              ),
            ),
          ),
          Positioned(
            left: _left,
            top: _top,
            child: GestureDetector(
              child: CircleAvatar(
                child: Text('A'), //要拖动和点击的widget
              ),
              onHorizontalDragUpdate: (DragUpdateDetails details) {
                setState(() {
                  _left += details.delta.dx;
                });
              },
              onHorizontalDragEnd: (DragEndDetails details) {
                print("onHorizontalDragEnd");
              },
              onTapDown: (details) {
                print("down");
              },
              onTapUp: (details) {
                print("up");
              },
            ),
          )
        ],
      ),
    );
  }
}
