import 'package:flutter/material.dart';
import 'NewRoute.dart';
import 'TipRoute.dart';

///
/// Created by dumingwei on 2019-10-09.
/// Desc:所谓路由管理，就是管理页面之间如何跳转，通常也可被称为导航管理。
///
class RouteManageTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('2.2:路由管理'),
      ),
      body: ListView(
        children: <Widget>[
          RaisedButton(
              child: Text('打开新的路由界面'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return NewRoute();
                }));
              }),
          RaisedButton(
              child: Text('路由传参'),
              onPressed: () async {
                var result = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return new TipRoute(
                      //路由参数
                      text: "我是提示xxxx");
                }));
                //输出`TipRoute`路由返回结果
                print("路由返回值: $result");
              }),
        ],
      ),
    );
  }
}
