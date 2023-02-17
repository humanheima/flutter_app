import 'package:flutter/material.dart';

import 'chapter_3/main.dart';
import 'chapter_4/main.dart';
import 'chapter_5/main.dart';
import 'chapter_6/main.dart';
import 'chapter_7/main.dart';

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
            ElevatedButton(
                child: Text('第3章'),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) {
                    return new Chapter3HomePage(title: 'Chapter 3 Home Page');
                  }));
                }),
            ElevatedButton(
                child: Text('第4章'),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) {
                    return new Chapter4HomePage();
                  }));
                }),
            ElevatedButton(
                child: Text('第5章'),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) {
                    return new Chapter5HomePage();
                  }));
                }),
            ElevatedButton(
                child: Text('第6章'),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) {
                    return new Chapter6HomePage();
                  }));
                }),
            ElevatedButton(
                child: Text('第7章'),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) {
                    return new Chapter7HomePage();
                  }));
                }),
          ],
        ),
      ),
    );
  }
}
