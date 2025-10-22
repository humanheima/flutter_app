import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

///
/// Created by 杜明伟 on 2023/3/21.
/// 手势识别

class Code82 extends StatefulWidget {
  @override
  _Code82State createState() => new _Code82State();
}

class _Code82State extends State<Code82> {
  String _operation = "No Gesture detected!"; //保存事件名

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('手势识别'),
      ),
      body: Center(
        child: GestureDetector(
          child: Container(
            alignment: Alignment.center,
            color: Colors.blue,
            width: 200,
            height: 100,
            child: Text(
              _operation,
              style: TextStyle(color: Colors.white),
            ),
          ),
          onTap: () => updateText('Tap'),
          onDoubleTap: () => updateText('onDoubleTap'),
          onLongPress: () => updateText('onLongPress'),
        ),
      ),
    );
  }

  void updateText(String text) {
    setState(() {
      _operation = text;
    });
  }
}

class DragTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DragTestState();
  }
}

class _DragTestState extends State<DragTest>
    with SingleTickerProviderStateMixin {
  double _top = 0.0; //距顶部的偏移
  double _left = 0.0; //距左边的偏移

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('手势识别'),
      ),
      body: Stack(
        children: [
          Positioned(
            child: GestureDetector(
              child: CircleAvatar(
                child: Text('A'),
              ),
              onPanDown: (DragDownDetails details) {
                print('用户手指按下：${details.globalPosition}');
              },
              //手指滑动时会触发此回调
              onPanUpdate: (DragUpdateDetails details) {
                print("用户手指拖动");
                //用户手指滑动时，更新偏移，重新构建
                setState(() {
                  _left += details.delta.dx;
                  _top += details.delta.dy;
                });
              },
              onPanEnd: (DragEndDetails details) {
                //打印滑动结束时在x、y轴上的速度
                print("拖动结束：" + details.velocity.toString());
              },
            ),
            top: _top,
            left: _left,
          ),
        ],
      ),
    );
  }
}

class ScaleTest extends StatefulWidget {
  const ScaleTest({Key? key}) : super(key: key);

  @override
  State createState() {
    return _ScaleTestState();
  }
}

class _ScaleTestState extends State<ScaleTest> {
  double _width = 200.0; //通过修改图片宽度来达到缩放效果

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('测试缩放'),
      ),
      body: Center(
        child: GestureDetector(
          //指定宽度，高度自适应
          child: Image.asset(
            "images/avatar.jpg",
            width: _width,
          ),
          onScaleUpdate: (ScaleUpdateDetails details) {
            setState(() {
              //缩放倍数在0.8到10倍之间
              _width = 200 * details.scale.clamp(0.8, 10.0);
            });
          },
        ),
      ),
    );
  }
}

/// 测试 GestureRecognizer
class GestureRecognizer extends StatefulWidget {
  const GestureRecognizer({Key? key}) : super(key: key);

  @override
  _GestureRecognizerState createState() => _GestureRecognizerState();
}

class _GestureRecognizerState extends State<GestureRecognizer> {
  TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer();
  bool _toggle = false; //变色开关

  @override
  void dispose() {
    //用到GestureRecognizer的话一定要调用其dispose方法释放资源
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('测试 GestureRecognizer'),
      ),
      body: Center(
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "你好世界"),
              TextSpan(
                text: "点我变色",
                style: TextStyle(
                  fontSize: 30.0,
                  color: _toggle ? Colors.blue : Colors.red,
                ),
                recognizer: _tapGestureRecognizer
                  ..onTap = () {
                    setState(() {
                      _toggle = !_toggle;
                    });
                  },
              ),
              TextSpan(text: "你好世界"),
            ],
          ),
        ),
      ),
    );
  }
}
