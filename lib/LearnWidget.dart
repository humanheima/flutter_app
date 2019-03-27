import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/basicwidgets/Button.dart';
import 'package:flutter_app/basicwidgets/ImageAndIcon.dart';
import 'package:flutter_app/basicwidgets/InputAndForm.dart';
import 'package:flutter_app/basicwidgets/SwitchAndCheckbox.dart';
import 'package:flutter_app/basicwidgets/TextAndStyle.dart';
import 'package:flutter_app/containerwidgets/PaddingTest.dart';
import 'package:flutter_app/containerwidgets/ScaffoldTabbarNavigation.dart';
import 'package:flutter_app/containerwidgets/TransformTest.dart';
import 'package:flutter_app/eventhandleandnotification/EventBus.dart';
import 'package:flutter_app/eventhandleandnotification/GestureDetectorTestRoute.dart';
import 'package:flutter_app/eventhandleandnotification/NotificationTest.dart';
import 'package:flutter_app/eventhandleandnotification/PointerEventTestRoute.dart';
import 'package:flutter_app/funtionalwidgets/InheritedWidgets.dart';
import 'package:flutter_app/funtionalwidgets/ThemeTestRoute.dart';
import 'package:flutter_app/funtionalwidgets/WillPopScope.dart';
import 'package:flutter_app/layoutwidgets/FlexTest.dart';
import 'package:flutter_app/layoutwidgets/RowColumnTest.dart';
import 'package:flutter_app/layoutwidgets/StackPositionedTest.dart';
import 'package:flutter_app/layoutwidgets/WrapFlow.dart';
import 'package:flutter_app/scrollablewidgets/CustomScrollViewtestRoute.dart';
import 'package:flutter_app/scrollablewidgets/GridViewTest.dart';
import 'package:flutter_app/scrollablewidgets/ListViewTest.dart';
import 'package:flutter_app/scrollablewidgets/ScrollControllerTest.dart';
import 'package:flutter_app/scrollablewidgets/SingleChildScrollViewTest.dart';
import 'package:flutter_app/animations/ScaleAnimationRoute.dart';
import 'package:flutter_app/animations/FadeRouteTest.dart';
import 'package:flutter_app/animations/HeroAnimationRoute.dart';
import 'package:flutter_app/animations/StaggerDemo.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        ///应用名称
        title: 'Flutter Code Sample for material.AppBar.actions',

        ///主题
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

        ///应用首页路由
        home: new MyHomePage(
          title: "learn widget",
        ));
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();

    bus.on("login", (arg) {
      print("Receive login event:" + arg);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new ListView(
          children: <Widget>[
            RaisedButton(
              child: Text(
                "文本字体样式",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  /* return new CounterWidget(
                    initialValue: 0,
                  );*/
                  return new TextWidget();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "按钮",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  /* return new CounterWidget(
                    initialValue: 0,
                  );*/
                  return new MyButtonWidget();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "图片和Icon",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  /* return new CounterWidget(
                    initialValue: 0,
                  );*/
                  return MyImageWidget();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "单选框和复选框",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  /* return new CounterWidget(
                    initialValue: 0,
                  );*/
                  return SwitchAndCheckBoxTestRoute();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "输入框和表单",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  /* return new CounterWidget(
                    initialValue: 0,
                  );*/
                  return FormTestRoute();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "线性布局Row、Column",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  /* return new CounterWidget(
                    initialValue: 0,
                  );*/
                  return RowColumnWidget();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "弹性布局Flex",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  /* return new CounterWidget(
                    initialValue: 0,
                  );*/
                  return FlexLayoutTestRoute();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "流式布局",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  /* return new CounterWidget(
                    initialValue: 0,
                  );*/
                  return WrapFlowTestRoute();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "层叠布局",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  /* return new CounterWidget(
                    initialValue: 0,
                  );*/
                  return StackPositionedRoute();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "Padding",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  /* return new CounterWidget(
                    initialValue: 0,
                  );*/
                  return PaddingTestRoute();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "Transform",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  /* return new CounterWidget(
                    initialValue: 0,
                  );*/
                  return TransformTestRoute();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "Scallold",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  /* return new CounterWidget(
                    initialValue: 0,
                  );*/
                  return ScaffoldRoute();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "SingleChildScrollView",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  /* return new CounterWidget(
                    initialValue: 0,
                  );*/
                  return SingleChildScrollViewRoute();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "ListView",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  /* return new CounterWidget(
                    initialValue: 0,
                  );*/
                  return ListViewRoute();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "GridView",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  /* return new CounterWidget(
                    initialValue: 0,
                  );*/
                  return GridViewRoute();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "CustomScrollView",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  /* return new CounterWidget(
                    initialValue: 0,
                  );*/
                  return CustomScrollViewRoute();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "ScrollControllerRoute 滚动监听及控制",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  /* return new CounterWidget(
                    initialValue: 0,
                  );*/
                  return ScrollNotificationTestRoute();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "WillPopScopeRoute",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  /* return new CounterWidget(
                    initialValue: 0,
                  );*/
                  return WillPopScopeRoute();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "InheritedWidgetRoute",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  /* return new CounterWidget(
                    initialValue: 0,
                  );*/
                  return InheritedWidgetRoute();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "ThemeTestRoute",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  /* return new CounterWidget(
                    initialValue: 0,
                  );*/
                  return ThemeTestRoute();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "PointerEventTestRoute",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  /* return new CounterWidget(
                    initialValue: 0,
                  );*/
                  return PointerEventTestRoute();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "手势识别GestureDetector",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context, new FadeRoute(builder: (context) {
                  return GestureDetectorTestRoute();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "使用EventBus发送事件",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                bus.emit("login", "Login event");
              },
            ),
            RaisedButton(
              child: Text(
                "send notification",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    //自自定义页面切换动画效果
                    PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 500),
                        pageBuilder: ((BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation) {
                          return new FadeTransition(
                            opacity: animation,
                            child: NotificationRoute(),
                          );
                        })));
              },
            ),
            RaisedButton(
              child: Text(
                "动画",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new CupertinoPageRoute(builder: (context) {
                  return ScaleAnimationRoute();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "共享元素动画",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new CupertinoPageRoute(builder: (context) {
                  return HeroAnimationRoute();
                }));
              },
            ),
            RaisedButton(
              child: Text(
                "交错动画",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new CupertinoPageRoute(builder: (context) {
                  return StaggerDemo();
                }));
              },
            ),
          ],
        ),
      ),
    );

    //return Echo(text: "hello world",);
  }
}

///实现了一个回显字符串的Echo widget。
class Echo extends StatelessWidget {
  final String text;
  final Color backgroundColor;

  //花括号扩起来的表示是可选命名参数
  const Echo({Key key, @required this.text, this.backgroundColor: Colors.grey});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: backgroundColor,
        child: Text(text),
      ),
    );
  }
}

class CounterWidget extends StatefulWidget {
  final initialValue;

  const CounterWidget({Key key, this.initialValue});

  @override
  State createState() => new _CounterWidgetState();
}

///关于State的生命周期,计数器的功能
class _CounterWidgetState extends State<CounterWidget> {
  int _counter;

  @override
  void initState() {
    super.initState();
    _counter = widget.initialValue;
    print("initState value is$_counter");
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Center(
        child: new Container(
      color: Colors.white,
      child: new FlatButton(
          //调用setState方法，会导致框架重新调用build方法
          onPressed: () => setState(() => ++_counter),
          child: Text('$_counter')),
    ));
  }

  @override
  void didUpdateWidget(CounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactivate");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  void reassemble() {
    super.reassemble();
    print("reassemble");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }
}

Widget build(BuildContext context) {
  return Text("remove");
}

///Widget状态管理

///Widget管理自身状态
class TAbboxA extends StatefulWidget {
  TAbboxA({Key k}) : super(key: k);

  @override
  State createState() {
    return new _TAbboxAState();
  }
}

class _TAbboxAState extends State<TAbboxA> {
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
            _active ? 'active' : 'inactive',
            style: new TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200,
        height: 200,
        decoration: new BoxDecoration(
            color: _active ? Colors.lightGreen[700] : Colors.grey),
      ),
    );
  }
}

///父widget管理子widget的state
///
///

class ParentWidget extends StatefulWidget {
  @override
  State createState() {
    return new _ParentWidgetState();
  }
}

class _ParentWidgetState extends State<ParentWidget> {
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

  //父类传入的回调函数
  final ValueChanged<bool> onChanged;

  TapboxB({Key key, this.active: false, @required this.onChanged})
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

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new TapboxC(
        active: _active,
        onChanged: _handleTapboxChanged,
      ),
    );
  }
}

///----------------------------- TapboxC ------------------------------

class TapboxC extends StatefulWidget {
  final bool active;
  final ValueChanged<bool> onChanged;

  TapboxC({Key key, this.active: false, @required this.onChanged})
      : super(key: key);

  _TapboxCState createState() => new _TapboxCState();
}

class _TapboxCState extends State<TapboxC> {
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
      onTapDown: _handleTapDown,
      // 处理按下事件
      onTapUp: _handleTapUp,
      // 处理抬起事件
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
