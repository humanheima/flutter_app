import 'package:flutter/material.dart';

///
/// Created by dumingwei on 2019/4/16.
/// Desc:
///

class WebViewPageUI extends StatefulWidget {
  final String? title;
  final String? url;

  WebViewPageUI({Key? key, this.title, this.url}) : super(key: key);

  @override
  State createState() {
    return WebViewPageUIState();
  }
}

class WebViewPageUIState extends State<WebViewPageUI> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? ""),
      ),
      body: Stack(
        children: <Widget>[
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container()
        ],
      ),
    );
  }
}
