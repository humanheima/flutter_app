import 'package:flutter/material.dart';

///
/// Crete by dumingwei on 2019/3/25
/// Desc: Pointer事件处理,这个没怎么看懂，以后再研究
///

class PointerEventTestRoute extends StatefulWidget {
  @override
  _PointerEventTestRoute createState() => _PointerEventTestRoute();
}

class _PointerEventTestRoute extends State<PointerEventTestRoute> {
  PointerEvent _event;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        alignment: Alignment.center,
        child: buildListenerTwo(),
      ),
    );
  }

  Listener buildListener() {
    return Listener(
      child: Container(
        alignment: Alignment.center,
        color: Colors.green,
        height: 150.0,
        width: 300.0,
        child: Text(
          _event?.toString() ?? "",
          style: TextStyle(color: Colors.white),
        ),
      ),
      onPointerDown: (PointerDownEvent event) {
        setState(() {
          _event = event;
        });
      },
      onPointerMove: (PointerMoveEvent event) {
        setState(() {
          _event = event;
        });
      },
      onPointerUp: (PointerUpEvent event) => setState(() => _event = event),
    );
  }

  Listener buildListener1() {
    return Listener(
        child: Listener(
            child: ConstrainedBox(
              constraints: BoxConstraints.tight(Size(300.0, 150.0)),
              child: Center(child: Text("Box A")),
            ),
            //behavior: HitTestBehavior.opaque,
            onPointerDown: (event) => print("down A")),
        //behavior: HitTestBehavior.deferToChild,
        behavior: HitTestBehavior.opaque,
        onPointerDown: (event) => print("down A"));
  }

  Listener buildListenerTwo() {
    return Listener(
      child: IgnorePointer(
        child: Listener(
          child: Container(
            color: Colors.red,
            width: 200.0,
            height: 100.0,
          ),
          onPointerDown: (event) => print("in"),
        ),
      ),
      onPointerDown: (event) => print("up"),
    );
  }

  Stack buildStack() {
    ///Stack 类比安卓中的FrameLayout
    return Stack(
      children: <Widget>[
        Listener(
          child: ConstrainedBox(
            constraints: BoxConstraints.tight(Size(300.0, 200.0)),
            child: DecoratedBox(decoration: BoxDecoration(color: Colors.blue)),
          ),
          onPointerDown: (event) => print("down0"),
        ),
        Listener(
          child: ConstrainedBox(
            constraints: BoxConstraints.tight(Size(200.0, 100.0)),
            child: Center(child: Text("左上角200*100范围内非文本区域点击")),
          ),
          onPointerDown: (event) => print("down1"),
          behavior: HitTestBehavior.translucent, //放开此行注释后可以"点透"
        )
      ],
    );
  }
}
