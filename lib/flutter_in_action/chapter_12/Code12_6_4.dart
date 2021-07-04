import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

///
/// Created by dumingwei on 2019-10-14.
/// Desc:
///

class webview_flutter_plugin_demo extends StatefulWidget {
  @override
  State createState() {
    return webview_flutter_plugin_demoState();
  }
}

class webview_flutter_plugin_demoState
    extends State<webview_flutter_plugin_demo> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: "https://flutterchina.club",
      //hidden: true,
      initialChild: Container(
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      appBar: AppBar(
        title: Text('使用flutter_webview_plugin中的WebView'),
      ),
    );
  }
}
