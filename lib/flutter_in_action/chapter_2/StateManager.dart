import 'package:flutter/material.dart';

///
/// Created by dumingwei on 2019-10-06.
/// Desc:状态管理
///

class StateManage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('状态管理'),
      ),
      body: new Center(
          child: new ListView(
        children: <Widget>[
          new TapboxA(),
          new Padding(padding: EdgeInsets.only(top: 20.0)),
          new ParentWidgetB(),
          new Padding(padding: EdgeInsets.only(top: 20.0)),
          new ParentWidgetC(),
          new Padding(padding: EdgeInsets.only(top: 20.0)),
        ],
      )),
    );
  }
}

/// TapboxA 管理自身状态.

///------------------------- TapboxA ----------------------------------

class TapboxA extends StatefulWidget {
  @override
  _TapboxAState createState() {
    return new _TapboxAState();
  }

  TapboxA({Key key}) : super(key: key);
}

class _TapboxAState extends State<TapboxA> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _handleTap,
      child: new Container(
          child: new Center(
            child: new Text(
              _active ? 'Active' : 'Inactive',
              style: new TextStyle(fontSize: 32.0, color: Colors.white),
            ),
          ),
          width: 200.0,
          height: 200.0,
          // decoration 属性可以用来设置背景色
          decoration: new BoxDecoration(
            color: _active ? Colors.lightGreen[700] : Colors.grey[600],
          )),
    );
  }
}

/// ParentWidget 为 TapboxB 管理状态.

///------------------------ ParentWidget --------------------------------

class ParentWidgetB extends StatefulWidget {
  @override
  State createState() {
    return new _ParentWidgetBState();
  }
}

class _ParentWidgetBState extends State<ParentWidgetB> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new TapboxB(active: _active, onChanged: _handleTapboxChanged),
    );
  }
}

///------------------------- TapboxB ----------------------------------

class TapboxB extends StatelessWidget {
  final bool active;

  ///父类传入的回调函数
  final ValueChanged<bool> onChanged;

  ///不传active的话，指定默认active
  ///@required 指定必须传递的参数
  TapboxB({Key key, this.active = false, @required this.onChanged})
      : super(key: key);

  void _handleTap() {
    onChanged(!active);
  }

  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _handleTap,
      child: new Container(
        child: new Center(
          child: new Text(
            active ? 'Active' : 'Inactive',
            style: new TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: new BoxDecoration(
          color: active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}

///混合管理状态，对于一些widget来说，混合管理的方式非常有用。
///在这种情况下，widget自身管理一些内部状态，而父widget管理一些其他外部状态。
///---------------------------- ParentWidget ----------------------------

class ParentWidgetC extends StatefulWidget {
  @override
  _ParentWidgetCState createState() => new _ParentWidgetCState();
}

class _ParentWidgetCState extends State<ParentWidgetC> {
  bool _active = false;

  void _handleTapBoxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new TapBoxC(
        active: _active,
        onChanged: _handleTapBoxChanged,
      ),
    );
  }
}

///----------------------------- TapBoxC ------------------------------

class TapBoxC extends StatefulWidget {
  final bool active;
  final ValueChanged<bool> onChanged;

  TapBoxC({Key key, this.active = false, @required this.onChanged})
      : super(key: key);

  _TapBoxCState createState() => new _TapBoxCState();
}

class _TapBoxCState extends State<TapBoxC> {
  bool _highlight = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    widget.onChanged(!widget.active);
  }

  Widget build(BuildContext context) {
    // 在按下时添加绿色边框，当抬起时，取消高亮
    return new GestureDetector(
      // 处理按下事件
      onTapDown: _handleTapDown,
      // 处理抬起事件
      onTapUp: _handleTapUp,
      onTap: _handleTap,
      onTapCancel: _handleTapCancel,
      child: new Container(
        child: new Center(
          child: new Text(widget.active ? 'Active' : 'Inactive',
              style: new TextStyle(fontSize: 32.0, color: Colors.white)),
        ),
        width: 200.0,
        height: 200.0,
        decoration: new BoxDecoration(
          color: widget.active ? Colors.lightGreen[700] : Colors.grey[600],
          border: _highlight
              ? new Border.all(
                  color: Colors.teal[700],
                  width: 10.0,
                )
              : null,
        ),
      ),
    );
  }
}
