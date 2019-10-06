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
                Padding(
                  padding: EdgeInsets.fromLTRB(40.0, 10.0, 0.0, 0.0),
                  child: Image(
                    image: AssetImage("images/avatar.jpg"),
                    width: 100.0,
                    height: 100.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(40.0, 10.0, 0.0, 0.0),
                  child: Image.asset(
                    "images/avatar.jpg",
                    width: 100.0,
                    height: 100.0,
                  ),
                ),
              ],
            ),
            new Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(40.0, 10.0, 0.0, 0.0),
                  child: Image.asset(
                    "images/avatar.jpg",
                    width: 100.0,
                    height: 200.0,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(40.0, 10.0, 0.0, 0.0),
                  child: Image(
                    image: AssetImage("images/avatar.jpg"),
                    width: 100.0,
                    fit: BoxFit.contain,
                    color: Colors.blue,
                    colorBlendMode: BlendMode.difference,
                  ),
                ),
              ],
            ),
            new Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(40.0, 10.0, 0.0, 0.0),
                  child: Image(
                    //从网络加载图片
                    image: NetworkImage(
                        "https://img-my.csdn.net/uploads/201407/26/1406383299_1976.jpg"),
                    width: 100.0,
                    height: 100.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(40.0, 10.0, 0.0, 0.0),
                  child: Image.network(
                    "https://img-my.csdn.net/uploads/201407/26/1406383291_6518.jpg",
                    width: 100.0,
                    height: 100.0,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 40.0, 0.0, 0.0),
              child: Row(
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
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 40.0, 0.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[getIconText()],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    IconFonts.book,
                    color: Colors.green,
                  ),
                  Icon(
                    IconFonts.wechat,
                    color: Colors.green,
                  ),
                ],
              ),
            ),
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
  icons += "\uE000";
// fingerprint: &#xE90D; or 0xE90D or E90D
  icons += "\uE90D";

  return Text(
    icons,
    style: TextStyle(
        fontFamily: "MaterialIcons", fontSize: 24.0, color: Colors.green),
  );
}

///自定义字体

class IconFonts {
  static const IconData book =
      const IconData(0xe629, fontFamily: 'bookIcon', matchTextDirection: true);

  // 微信图标
  static const IconData wechat =
      //图标对应对的16进制的整数，获取这个整数，可以打开font_wexin目录下的demo_index.xml中看到
      const IconData(0xe620,
          fontFamily: 'wechateIcon', matchTextDirection: true);
}
