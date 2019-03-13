import 'dart:core';

import 'package:flutter/material.dart';

///图片和icon

class MyImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("按钮"),
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                Image(
                  image: AssetImage("images/avatar.png"),
                  width: 100.0,
                  height: 100.0,
                ),
                Image.asset(
                  "images/avatar.png",
                  width: 100.0,
                  height: 100.0,
                ),
              ],
            ),
            new Row(
              children: <Widget>[
                Image.asset(
                  "images/avatar.png",
                  width: 100.0,
                  height: 200.0,
                ),
                Image(
                  image: AssetImage("images/avatar.png"),
                  width: 100.0,
                  color: Colors.blue,
                  colorBlendMode: BlendMode.difference,
                ),
              ],
            ),
            new Row(
              children: <Widget>[
                Image(
                  //从网络加载图片
                  image: NetworkImage(
                      "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4"),
                  width: 50.0,
                  height: 50.0,
                ),
                Image.network(
                  "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4",
                  width: 50.0,
                  height: 50.0,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.accessible,
                  color: Colors.green,
                ),
                Icon(
                  Icons.error,
                  color: Colors.green,
                ),
                Icon(
                  Icons.fingerprint,
                  color: Colors.green,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  MyIcons.wechat,
                  color: Colors.green,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Text getIconText() {
  String icons = "";
// accessible: &#xE914; or 0xE914 or E914
  icons += "\uE914";
// error: &#xE000; or 0xE000 or E000
  icons += " \uE000";
// fingerprint: &#xE90D; or 0xE90D or E90D
  icons += " \uE90D";

  return Text(
    icons,
    style: TextStyle(
        fontFamily: "MaterialIcons", fontSize: 24.0, color: Colors.green),
  );
}

///自定义字体

class MyIcons {
  // 微信图标
  static const IconData wechat =
      //图标对应对的16进制的整数，获取这个整数，可以用浏览器打开font_wexin目录下的demo_index.xml中看到
      const IconData(0xe620, fontFamily: 'myIcon', matchTextDirection: true);
}
