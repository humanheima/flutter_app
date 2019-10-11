import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

///
/// Crete by dumingwei on 2019/3/31
/// Desc:
///

class TurnBoxRoute extends StatefulWidget {
  @override
  _TurnBoxRouteState createState() {
    return _TurnBoxRouteState();
  }
}

class _TurnBoxRouteState extends State<TurnBoxRoute> {
  double _turns = 0.0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('10.3 组合实例：TurnBox'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TurnBox(
              turns: _turns,
              speed: 500,
              child: Icon(
                Icons.refresh,
                size: 50,
              ),
            ),
            TurnBox(
              turns: _turns,
              speed: 1000,
              child: Icon(
                Icons.refresh,
                size: 150.0,
              ),
            ),
            RaisedButton(
              child: Text("顺时针旋转1/5圈"),
              onPressed: () {
                setState(() {
                  _turns += 0.2;
                });
              },
            ),
            RaisedButton(
              child: Text("逆时针旋转1/5圈"),
              onPressed: () {
                setState(() {
                  _turns -= 0.2;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TurnBox extends StatefulWidget {
  final double turns;
  final int speed;
  final Widget child;

  const TurnBox({Key key, this.turns = 0.0, this.speed = 200, this.child})
      : super(key: key);

  @override
  State createState() {
    return new _TurnBoxState();
  }
}

class _TurnBoxState extends State<TurnBox> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        vsync: this, lowerBound: -double.infinity, upperBound: double.infinity);

    _controller.value = widget.turns;
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: widget.child,
    );
  }

  @override
  void didUpdateWidget(TurnBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    //旋转角度发生变化时执行过渡动画
    if (oldWidget.turns != widget.turns) {
      _controller.animateTo(widget.turns,
          duration: Duration(milliseconds: widget.speed ?? 200),
          curve: Curves.easeOut);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class MyRichText extends StatefulWidget {
  final String text;
  final TextStyle linkStyle;

  MyRichText({Key key, this.text, this.linkStyle}) : super(key: key);

  @override
  State createState() {
    return _MyRichTextState();
  }
}

class _MyRichTextState extends State<MyRichText> {
  TextSpan _textSpan;

  TextSpan parseText(String text) {
    // 耗时操作：解析文本字符串，构建出TextSpan。
    // 省略具体实现。
    return TextSpan(text: text);
  }

  @override
  void initState() {
    _textSpan = parseText(widget.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: _textSpan,
    );
  }

  @override
  void didUpdateWidget(MyRichText oldWidget) {
    if (widget.text != oldWidget.text) {
      _textSpan = parseText(widget.text);
    }
    super.didUpdateWidget(oldWidget);
  }
}
