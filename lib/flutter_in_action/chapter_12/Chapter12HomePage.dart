import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Code12_3.dart';
import 'Code12_6_3.dart';
import 'Code12_6_4.dart';
import 'Code12_6_1.dart';
import 'Code12_6_2.dart';
import 'package:camera/camera.dart';

///
/// Created by dumingwei on 2019-10-12.
/// Desc:
///
class Chapter12HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第12章：包与插件'),
      ),
      body: ListView(
        children: <Widget>[
          RaisedButton(
            child: Text("12.3 开发Flutter插件"),
            onPressed: () {
              Navigator.push(context,
                  new CupertinoPageRoute(builder: (context) {
                return Code12_3();
              }));
            },
          ),
          RaisedButton(
            child: Text("camera demo"),
            onPressed: () async {
              List<CameraDescription> cameras;
              try {
                cameras = await availableCameras();
              } on CameraException catch (e) {
                print('getCamera error ${e.code} ,${e.description}');
                return;
              }
              print(cameras);
              Navigator.push(context,
                  new CupertinoPageRoute(builder: (context) {
                return Code12_6_1(cameras);
              }));
            },
          ),
          RaisedButton(
            child: Text("PlatformView"),
            onPressed: () {
              Navigator.push(context,
                  new CupertinoPageRoute(builder: (context) {
                return Code12_6_2();
              }));
            },
          ),
          RaisedButton(
            child: Text("使用webview_flutter中的WebView"),
            onPressed: () {
              Navigator.push(context,
                  new CupertinoPageRoute(builder: (context) {
                return webview_flutter_demo();
              }));
            },
          ),
          RaisedButton(
            child: Text("使用flutter_webview_plugin中的WebView"),
            onPressed: () {
              Navigator.push(context,
                  new CupertinoPageRoute(builder: (context) {
                return webview_flutter_plugin_demo();
              }));
            },
          ),
        ],
      ),
    );
  }

  void toCameraDemo() {}
}
