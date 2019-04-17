import 'package:flutter/material.dart';
import 'package:flutter_app/wanandroid_flutter/api/CommonService.dart';
import 'package:flutter_app/wanandroid_flutter/model/SystemTreeModel.dart';
import 'package:flutter_app/wanandroid_flutter/ui/SystemTreeContentPageUI.dart';

///
/// Created by dumingwei on 2019/4/13.
/// Desc:
///

class SystemTreeUI extends StatefulWidget {
  @override
  State createState() {
    return SystemTreeUIState();
  }
}

class SystemTreeUIState extends State<SystemTreeUI>
    with AutomaticKeepAliveClientMixin {
  List<SystemTreeData> _datas = List();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: RefreshIndicator(
          child: ListView.separated(
              itemBuilder: _renderRow,
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  height: 0.5,
                  color: Colors.black26,
                );
              },
              itemCount: _datas.length),
          onRefresh: _getData),
    );
  }

  Future<Null> _getData() async {
    CommonService().getSystemTree((SystemTreeModel _systemTreeModel) {
      setState(() {
        _datas = _systemTreeModel.data;
      });
    });
  }

  Widget _renderRow(BuildContext context, int index) {
    if (index < _datas.length) {
      return InkWell(
        onTap: () {
          _onItemClick(_datas[index]);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      _datas[index].name,
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: buildChildren(_datas[index].children),
                  )
                ],
              ),
            )),
            Icon(Icons.chevron_right),
          ],
        ),
      );
    }
    return null;
  }

  void _onItemClick(SystemTreeData data) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      //return SystemTreeContentPageUI(new ValueKey(data));
      return SystemTreeContentPageUI(new ValueKey(data));
    }));
  }

  buildChildren(List<SystemTreeChild> children) {
    List<Widget> tiles = [];
    Widget content;
    for (var item in children) {
      tiles.add(new Chip(label: new Text(item.name)));
    }
    content = Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      alignment: WrapAlignment.start,
      children: tiles,
    );
    return content;
  }

  @override
  bool get wantKeepAlive {
    return true;
  }
}
