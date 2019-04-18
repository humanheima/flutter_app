import 'package:flutter/material.dart';
import 'package:flutter_app/wanandroid_flutter/model/NaviModel.dart';
import 'package:flutter_app/wanandroid_flutter/api/CommonService.dart';
import 'package:flutter_app/wanandroid_flutter/ui/WebViewPageUI.dart';

///
/// Created by dumingwei on 2019/4/13.
/// Desc:导航
///

class NaviPageUI extends StatefulWidget {
  @override
  State createState() => NaviPageUIState();
}

class NaviPageUIState extends State<NaviPageUI> {
  List<NaviData> _naviTitles = List();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _rightListView(context),
      ),
    );
  }

  Future<Null> _getData() async {
    CommonService().getNaviList((NaviModel _naviModel) {
      setState(() {
        _naviTitles = _naviModel.data;
      });
    });
  }

  _rightListView(BuildContext context) {
    return ListView.builder(
      itemBuilder: _renderContent,
      itemCount: _naviTitles.length,
    );
  }

  Widget _renderContent(BuildContext context, int index) {
    return Container(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                _naviTitles[index].name,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: buildChildren(_naviTitles[index].articles),
            )
          ],
        ),
      ),
    );
  }

  buildChildren(List<NaviArticle> articles) {
    List<Widget> tiles = [];
    Widget content;
    for (NaviArticle item in articles) {
      tiles.add(InkWell(
        child: Chip(label: Text(item.title)),
        onTap: () {
          _onItemClick(item);
        },
      ));
    }

    content = Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      alignment: WrapAlignment.start,
      children: tiles,
    );
    return content;
  }

  void _onItemClick(NaviArticle item) async {
    await Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return WebViewPageUI(
        title: item.title,
        url: item.link,
      );
    }));
  }
}
