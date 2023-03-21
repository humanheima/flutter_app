import 'package:flutter/material.dart';

///
/// Crete by dumingwei on 2019/3/24
/// Desc: 颜色和主题
/// Link: https://book.flutterchina.club/chapter7/theme.html#_7-4-1-%E9%A2%9C%E8%89%B2
///
///

///一个背景颜色和Title可以自定义的导航栏，并且背景色为深色时我们应该让Title显示为浅色；背景色为浅色时，Title显示为深色。
class NavBar extends StatelessWidget {
  final String title;
  final Color color;

  NavBar({Key key, this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 52, minWidth: double.infinity),
      decoration: BoxDecoration(color: color, boxShadow: [
        //阴影
        BoxShadow(
          color: Colors.black26,
          offset: Offset(0, 3),
          blurRadius: 3,
        )
      ]),
      child: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color:
                color.computeLuminance() < 0.5 ? Colors.white : Colors.black),
      ),
      alignment: Alignment.center,
    );
  }
}

class ThemeTestRoute extends StatefulWidget {
  @override
  State createState() {
    return _ThemeTestRouteState();
  }
}

class _ThemeTestRouteState extends State<ThemeTestRoute> {


  ////当前路由主题色
  Color _themeColor = Colors.teal;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Theme(
      data: ThemeData(
          primarySwatch: _themeColor,//用于导航栏、FloatingActionButton的背景色等
          iconTheme: IconThemeData(color: _themeColor)),//用于Icon颜色
      child: Scaffold(
        appBar: AppBar(
          title: Text("7.4 颜色和主题"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                NavBar(
                  color: Colors.blue,
                  title: '标题',
                ),
                NavBar(
                  color: Colors.white,
                  title: '标题',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.favorite),
                Icon(Icons.airport_shuttle),
                Text("颜色跟随主题")
              ],
            ),
            Theme(
              data: themeData.copyWith(
                  iconTheme: themeData.iconTheme.copyWith(color: Colors.black)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.favorite),
                  Icon(Icons.airport_shuttle),
                  Text("  颜色固定黑色")
                ],
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => setState(() => _themeColor =
              _themeColor == Colors.teal ? Colors.blue : Colors.teal),
          child: Icon(Icons.palette),
        ),
      ),
    );
  }
}
