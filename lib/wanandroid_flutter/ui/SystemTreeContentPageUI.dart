import 'package:flutter/material.dart';
import 'package:flutter_app/wanandroid_flutter/api/CommonService.dart';
import 'package:flutter_app/wanandroid_flutter/model/SystemTreeContentModel.dart';
import 'package:flutter_app/wanandroid_flutter/model/SystemTreeModel.dart';
import 'package:flutter_app/wanandroid_flutter/utils/RouteUtil.dart';
import 'package:flutter_app/wanandroid_flutter/utils/timeline_util.dart';

///
/// Created by dumingwei on 2019/4/17.
/// Desc:知识体系详情
///

class SystemTreeContentPageUI extends StatefulWidget {
  final SystemTreeData data;

  SystemTreeContentPageUI(ValueKey<SystemTreeData> key)
      : data = key.value,
        super(key: key);

  @override
  State createState() {
    return SystemTreeContentPageUIState();
  }
}

class SystemTreeContentPageUIState extends State<SystemTreeContentPageUI>
    with TickerProviderStateMixin {
  late SystemTreeData _data;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _data = widget.data;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final children = _data.children ?? [];
    // Ensure TabController has at least 1 tab to avoid assertion; if no real children, show a single empty tab
    _tabController = TabController(length: children.isNotEmpty ? children.length : 1, vsync: this);
    return Scaffold(
      appBar: AppBar(
        title: Text(_data.name ?? ''),
        elevation: 0.4,
        bottom: new TabBar(
          tabs: (children.isNotEmpty
                  ? children.map((SystemTreeChild item) {
                      return Tab(
                        text: item.name ?? '',
                      );
                    }).toList()
                  : [Tab(text: '')])
              .toList(),
          isScrollable: true,
          controller: _tabController,
        ),
      ),
      body: new TabBarView(
          controller: _tabController,
          children: (children.isNotEmpty
                  ? children.map((item) {
                      return NewsList(id: item.id ?? 0);
                    }).toList()
                  : [Container()])
              .toList()),
    );
  }
}

///知识体系文章列表
class NewsList extends StatefulWidget {
  final int id;

  NewsList({Key? key, required this.id}) : super(key: key);

  @override
  State createState() {
    return _NewsListState();
  }
}

class _NewsListState extends State<NewsList> {
  List<SystemTreeContentChild> _datas = <SystemTreeContentChild>[];
  ScrollController _scrollController = ScrollController();

  int _page = 0;

  @override
  void initState() {
    super.initState();
    getData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
          child: ListView.separated(
              itemBuilder: _renderRow,
              separatorBuilder: _separatorView,
              controller: _scrollController,
              itemCount: _datas.length + 1),
          onRefresh: getData),
    );
  }

  Future<Null> getData() async {
    _page = 0;
    final int _id = widget.id;
    CommonService().getSystemTreeContent((SystemTreeContentModel model) {
      setState(() {
        _datas = model.data?.datas ?? [];
      });
    }, _page, _id);
  }

  Future<Null> _getMore() async {
    _page++;
    final int _id = widget.id;
    CommonService().getSystemTreeContent((SystemTreeContentModel model) {
      setState(() {
        _datas.addAll(model.data?.datas ?? []);
      });
    }, _page, _id);
  }

  Widget _renderRow(BuildContext context, int index) {
    if (index < _datas.length) {
      var item = _datas[index];
      return InkWell(
        child: new Column(
          children: <Widget>[
            new Container(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    item.author ?? '',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  new Expanded(
                    child: new Text(
                      TimelineUtil.format(item.publishTime ?? 0),
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      item.title ?? '',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ))
                  ],
                )),
            Container(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Row(
                  children: <Widget>[
                    Text(
                      item.superChapterName ?? '',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    new Text(
                      "/" + (item.chapterName ?? ''),
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                      textAlign: TextAlign.right,
                    ),
                  ],
                )),
          ],
        ),
        onTap: () {
          RouteUtil.toWebView(context, item.title ?? '', item.link ?? '');
        },
      );
    }
    return Container(
      padding: EdgeInsets.all(16),
      alignment: Alignment.center,
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      ),
    );
  }

  Widget _separatorView(BuildContext context, int index) {
    return Container(
      height: 0.5,
      color: Colors.black26,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}
