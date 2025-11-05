import 'package:flutter/material.dart';

///
/// Created by dumingwei on 2019/4/13.
/// Desc:
///

class SearchPageUI extends StatefulWidget {
  @override
  State createState() {
    return SearchPageUIState();
  }
}

class SearchPageUIState extends State<SearchPageUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('搜索'),
      ),
      body: Center(
        child: Text('搜索功能待实现'),
      ),
    );
  }
}
