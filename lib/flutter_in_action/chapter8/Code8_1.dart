import 'package:flutter/material.dart';

///
/// Created by 杜明伟 on 2023/3/21.
/// 原始指针事件处理

class Code81 extends StatefulWidget {
  @override
  _Code81State createState() => new _Code81State();
}

class _Code81State extends State<Code81> {
  PointerEvent _event = PointerCancelEvent();

  // TODO: add state variables and methods

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('原始指针事件处理'),
      ),
      body: Listener(
        child: Container(
          alignment: Alignment.center,
          color: Colors.blue,
          width: 300,
          height: 150,
          child: Text(
            '${_event.localPosition}',
            style: TextStyle(color: Colors.white),
          ),
        ),
        onPointerDown: (PointerDownEvent event) =>
            setState(() => _event = event),
        onPointerMove: (PointerMoveEvent event) =>
            setState(() => _event = event),
        onPointerUp: (PointerUpEvent event) => setState(() => _event = event),
      ),
    );
  }
}
