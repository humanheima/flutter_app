import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

///
/// Created by dumingwei on 2019/4/16.
/// Desc:
///

class WebViewPageUI extends StatefulWidget {
  String title;
  String url;

  WebViewPageUI({Key key, this.title, this.url}) : super(key: key);

  @override
  State createState() {
    return WebViewPageUIState();
  }
}

class WebViewPageUIState extends State<WebViewPageUI> {
  bool isLoading = false;

  final FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin.onStateChanged.listen((state) {
      debugPrint('state:_' + state.type.toString());
      if (state.type == WebViewState.finishLoad) {
        setState(() {
          isLoading = false;
        });
      } else if (state.type == WebViewState.startLoad) {
        setState(() {
          isLoading = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url: widget.url,
      appBar: new AppBar(
        elevation: 0.4,
        title: Text(widget.title),
        bottom: new PreferredSize(
            child: isLoading
                ? new LinearProgressIndicator()
                : new Divider(
                    height: 1.0,
                    color: Theme.of(context).primaryColor,
                  ),
            preferredSize: const Size.fromHeight(1.0)),
      ),
      withZoom: false,
      withLocalStorage: false,
      withJavascript: true,
    );
  }
}
