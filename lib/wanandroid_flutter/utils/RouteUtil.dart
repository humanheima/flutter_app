import 'package:flutter/material.dart';
import 'package:flutter_app/wanandroid_flutter/ui/WebViewPageUI.dart';
import 'package:flutter_app/enjoy/view/webview_page.dart';

///
/// Created by dumingwei on 2019/4/16.
/// Desc:
///

class RouteUtil {
  static void toWebView(BuildContext context, String title, String link) async {
    await Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new WebViewPageUI(title: title, url: link);
      //return new WebViewPage(title: title, url: link);
    }));
  }
}
