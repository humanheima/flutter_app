import 'package:flutter/material.dart';
import 'SearchResultPageUI.dart';
import 'SearchHotPageUI.dart';

///
/// Created by dumingwei on 2019/4/13.
/// Desc:
///

class SearchPageUI extends StatefulWidget {
  final String searchStr;

  SearchPageUI({this.searchStr});

  @override
  State createState() {
    return SearchPageUIState(searchStr: searchStr);
  }
}

class SearchPageUIState extends State<SearchPageUI> {
  String searchStr;

  TextEditingController _controller = new TextEditingController();

  FocusNode focusNode = new FocusNode();
  SearchResultPageUI _searchListPage;

  SearchPageUIState({this.searchStr});

  @override
  void initState() {
    super.initState();
    _controller = new TextEditingController(text: searchStr);

    changeContent();
  }

  void changeContent() {
    focusNode.unfocus();
    setState(() {
      _searchListPage = new SearchResultPageUI(new ValueKey(_controller.text));
    });
  }

  @override
  Widget build(BuildContext context) {
    TextField searchField = TextField(
      autofocus: true,
      decoration: new InputDecoration(
        border: InputBorder.none,
        hintText: '搜索关键字',
      ),
      focusNode: focusNode,
      controller: _controller,
    );
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.4,
        title: searchField,
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.search), onPressed: changeContent),
          new IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                setState(() {
                  _controller.clear();
                });
              })
        ],
      ),
      body: (_controller.text == null || _controller.text.isEmpty)
          ? new Center(
              child: SearchHotPageUI(),
            )
          : _searchListPage,
    );
  }
}
