import 'package:flutter/material.dart';

import 'chapter_2/Chapter2HomePage.dart';
import 'chapter_3/main.dart';
import 'chapter_4/main.dart';
import 'chapter_5/main.dart';
import 'chapter_6/main.dart';
import 'chapter_7/main.dart';
import 'chapter_8/Chapter8HomePage.dart';
import 'chapter_9/Chapter9HomePage.dart';

///
/// Created by dumingwei on 2019-10-07.
/// Desc:
///

class FlutterInActionMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('《Flutter in action》'),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            RaisedButton(
                child: Text('第2章'),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) {
                    return new Chapter2HomePage();
                  }));
                }),
            RaisedButton(
                child: Text('第3章'),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) {
                    return new Chapter3HomePage(title: 'Chapter 3 Home Page');
                  }));
                }),
            RaisedButton(
                child: Text('第4章'),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) {
                    return new Chapter4HomePage();
                  }));
                }),
            RaisedButton(
                child: Text('第5章'),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) {
                    return new Chapter5HomePage();
                  }));
                }),
            RaisedButton(
                child: Text('第6章'),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) {
                    return new Chapter6HomePage();
                  }));
                }),
            RaisedButton(
                child: Text('第7章'),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) {
                    return new Chapter7HomePage();
                  }));
                }),
            RaisedButton(
                child: Text('第8章'),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) {
                    return new Chapter8HomePage();
                  }));
                }),
            RaisedButton(
                child: Text('第9章'),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) {
                    return new Chapter9HomePage();
                  }));
                }),
          ],
        ),
      ),
    );
  }
}
