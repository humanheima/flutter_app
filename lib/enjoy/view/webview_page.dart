import 'package:flutter/material.dart';

///
/// Created by dumingwei on 2019/4/3.
/// Desc:
///

class WebViewPage extends StatefulWidget {
  final String url;
  final String title;

  WebViewPage({this.url = "", this.title = ""});

  @override
  State createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Text(widget.url),
    );
  }
}
