import 'package:flutter/material.dart';

import 'Code6_2.dart';
import 'Code6_3.dart';
import 'Code6_4.dart';
import 'Code6_5.dart';
import 'Code6_6.dart';

///
/// Created by dumingwei on 2019-10-08.
/// Desc:
///
class Chapter6HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('第6章'),
        ),
        body: ListView(
          children: <Widget>[
            ElevatedButton(
              child: Text(
                "6.2 SingleChildScrollView",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return SingleChildScrollViewTestRoute();
                }));
              },
            ),
            ElevatedButton(
              child: Text(
                "6.3 ListView",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return ListViewRoute();
                }));
              },
            ),
            ElevatedButton(
              child: Text(
                "6.4 GridView",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return GridViewTestRoute();
                }));
              },
            ),
            ElevatedButton(
              child: Text(
                "6.5 CustomScrollView",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return CustomScrollViewRoute();
                }));
              },
            ),
            ElevatedButton(
              child: Text(
                "6.6 滚动监听及控制",
                style: new TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  //return ScrollControllerTestRoute();
                  return ScrollNotificationTestRoute();
                }));
              },
            ),
          ],
        ));
  }
}
