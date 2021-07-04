import 'package:flutter/material.dart';
import 'Code13_1.dart';
import 'Code13_2.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

///
/// Created by dumingwei on 2019-10-15.
/// Desc:
///
class Chapter13HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第13章国际化'),
      ),
      body: ListView(
        children: <Widget>[
          RaisedButton(
              child: Text('13.1 让App支持多语言'),
              onPressed: () {
                return new MaterialPageRoute(builder: (BuildContext context) {
                  return Code13_1();
                });
              }),
          RaisedButton(
              child: Text('13.2 实现Localizations'),
              onPressed: () {
                return new MaterialPageRoute(builder: (BuildContext context) {
                  return Code13_2();
                });
              }),
          RaisedButton(child: Text('使用Intl包'), onPressed: () {}),
          RaisedButton(child: Text('13.4 国际化常见问题'), onPressed: () {}),
        ],
      ),
    );
  }
}
