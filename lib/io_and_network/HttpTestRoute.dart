import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

///
/// Created by dumingwei on 2019/3/31.
/// Desc:通过HttpClient发起HTTP请求
///

class HttpTestRoute extends StatefulWidget {
  @override
  State createState() => _HttpTestRouteState();
}

class _HttpTestRouteState extends State<HttpTestRoute> {
  bool _loading = false;
  String _text = "";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                child: null,
                padding: EdgeInsets.only(top: 100.0),
              ),
              ElevatedButton(
                child: Text('获取百度首页'),
                onPressed: _loading
                    ? null
                    : () async {
                        setState(() {
                          _loading = true;
                          _text = "正在请求";
                        });
                        try {
                          //创建一个HttpClient
                          HttpClient httpClient = new HttpClient();
                          //打开Http连接
                          HttpClientRequest request = await httpClient
                              .getUrl(Uri.parse("https://www.baidu.com"));
                          //等待连接服务器（会将请求信息发送给服务器）
                          HttpClientResponse response = await request.close();
                          //读取响应内容
                          _text = await response.transform(utf8.decoder).join();
                          //输出响应头
                          print(response.headers);
                          //关闭client后，通过该client发起的所有请求都会中止。
                          httpClient.close();
                        } catch (e) {
                          _text = "请求失败：$e";
                          print(e);
                        } finally {
                          setState(() {
                            _loading = false;
                          });
                        }
                      },
              ),
              Container(
                width: MediaQuery.of(context).size.width - 50.0,
                child: Text(_text.replaceAll(new RegExp(r"\s"), "")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
