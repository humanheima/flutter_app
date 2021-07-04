import 'package:flutter/material.dart';
import 'package:flutter_app/wanandroid_flutter/api/CommonService.dart';
import 'package:flutter_app/wanandroid_flutter/model/HotwordData.dart';

import 'SearchPageUI.dart';

///
/// Created by dumingwei on 2019-10-27.
/// Desc:
///

class SearchHotPageUI extends StatefulWidget {
  @override
  State createState() {
    return SearchHotPageUIState();
  }
}

class SearchHotPageUIState extends State<SearchHotPageUI> {
  List<Widget> hotKeyWidgets = new List();

  @override
  void initState() {
    super.initState();

    _getHotKey();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        new Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: new Text('大家都在搜', style: new TextStyle(fontSize: 16))),
        new Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              alignment: WrapAlignment.start,
              children: hotKeyWidgets,
            )),
      ],
    );
  }

  Future<Null> _getHotKey() async {
    CommonService().getSearchHotWord((HotWordModel _hotWordModel) {
      setState(() {
        List<Data> datas = _hotWordModel.data;

        hotKeyWidgets.clear();

        for (var value in datas) {
          Widget actionChip = new ActionChip(
              label: new Text(value.name),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacement(new MaterialPageRoute(builder: (context) {
                  return new SearchPageUI(
                    searchStr: value.name,
                  );
                }));
              });
          hotKeyWidgets.add(actionChip);
        }
      });
    });
  }
}
