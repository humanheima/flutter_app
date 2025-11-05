import 'package:flutter/material.dart';
import 'package:flutter_app/flutter_in_action/chapter11/main.dart';
import 'package:flutter_app/flutter_in_action/chapter8/main.dart';

import 'chapter_3/main.dart';
import 'chapter_4/main.dart';
import 'chapter_5/main.dart';
import 'chapter_6/main.dart';
import 'chapter_7/main.dart';

///
/// Created by dumingwei on 2019-10-07.
/// Desc:
///
///
///
///

void main() => runApp(FlutterInActionMain());

class FlutterInActionMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('《Flutter in action》'),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            TextButton(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                    child: Text('第5章'),
                    onPressed: () {
                      Navigator.push(context,
                          new MaterialPageRoute(builder: (context) {
                        return new Chapter5HomePage();
                      }));
                    }),
                IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          new MaterialPageRoute(builder: (context) {
                        return new Chapter5HomePage();
                      }));
                    },
                    icon: Icon(Icons.favorite))
              ],
            ),
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
            ElevatedButton(
                child: Text('第8章'),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) {
                    return new Chapter8HomePage();
                  }));
                }),
            ElevatedButton(
                child: Text('第11章'),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) {
                    return new Chapter11HomePage();
                  }));
                }),
          ],
        ),
      ),
    );
  }
}
