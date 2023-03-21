import 'package:flutter/material.dart';

///
/// Crete by dumingwei on 2019/3/24
/// Desc: 导航返回拦截 WillPopScope 想要pop出来
///

class WillPopScopeRoute extends StatefulWidget {
  @override
  _WillPopScopeRouteState createState() {
    return _WillPopScopeRouteState();
  }
}

class _WillPopScopeRouteState extends State<WillPopScopeRoute> {
  List<IconData> _icons = [];
  DateTime _lastPressAt; //上次点击时间

  @override
  Widget build(BuildContext context) {
    return Material(
      child: new WillPopScope(
          child: Column(
            children: <Widget>[
              AppBar(
                title: Text('7.1 导航返回拦截（WillPopScope）'),
              ),
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                child: Text('1秒内连续点击两次返回键退出'),
              ))
            ],
          ),
          onWillPop: () async {
            if (_lastPressAt == null ||
                DateTime.now().difference(_lastPressAt) >
                    Duration(seconds: 1)) {
              _lastPressAt = DateTime.now();
              return false;
            }
            return true;
          }),
    );
  }
}
