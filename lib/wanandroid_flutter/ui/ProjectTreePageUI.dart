import 'package:flutter/material.dart';
import 'package:flutter_app/wanandroid_flutter/api/CommonService.dart';
import 'package:flutter_app/wanandroid_flutter/model/ProjectTreeModel.dart';
import 'package:flutter_app/wanandroid_flutter/model/ProjectListModel.dart';
import 'package:flutter_app/wanandroid_flutter/ui/WebViewPageUI.dart';
import 'package:flutter_app/wanandroid_flutter/utils/timeline_util.dart';

///
/// Created by dumingwei on 2019/4/13.
/// Desc: 完整的项目
///

class ProjectTreePageUI extends StatefulWidget {
  @override
  State createState() => ProjectTreePageUIState();
}

class ProjectTreePageUIState extends State<ProjectTreePageUI>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  List<ProjectTreeData> _datas = <ProjectTreeData>[];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // for AutomaticKeepAliveClientMixin
    final tabs = _datas.isNotEmpty ? _datas : [ProjectTreeData.fromParams()];
    _tabController = TabController(length: tabs.length, vsync: this);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.4,
        title: TabBar(
          controller: _tabController,
          tabs: (tabs.map((ProjectTreeData item) {
            return Tab(
              text: item.name ?? '',
            );
          }).toList()),
          isScrollable: true,
        ),
      ),
      body: TabBarView(
        children: (tabs.map((item) {
          return NewsList(id: item.id ?? 0);
        }).toList()),
        controller: _tabController,
      ),
    );
  }

  Future<Null> _getData() async {
    CommonService().getProjectTree((ProjectTreeModel _projectTreeModel) {
      setState(() {
        _datas = _projectTreeModel.data ?? <ProjectTreeData>[];
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}

class NewsList extends StatefulWidget {
  final int id;

  NewsList({Key? key, required this.id}) : super(key: key);

  @override
  State createState() {
    return _NewsListState();
  }
}

class _NewsListState extends State<NewsList> {
  List<ProjectTreeListDatas> _datas = <ProjectTreeListDatas>[];
  ScrollController _scroll_controller = ScrollController();
  int _page = 1;

  @override
  void initState() {
    super.initState();
    _getData();
    _scroll_controller.addListener(() {
      if (_scroll_controller.position.pixels ==
          _scroll_controller.position.maxScrollExtent) {
        _getMore();
      }
    });
  }

  Future<Null> _getData() async {
    _page = 1;
    int _id = widget.id;
    CommonService().getProjectList((ProjectTreeListModel _projectTreeListModel) {
      setState(() {
        _datas = _projectTreeListModel.data?.datas ?? <ProjectTreeListDatas>[];
      });
    }, _page, _id);
  }

  Future<Null> _getMore() async {
    _page++;
    int _id = widget.id;
    CommonService().getProjectList((ProjectTreeListModel _projectTreeListModel) {
      setState(() {
        _datas.addAll(_projectTreeListModel.data?.datas ?? <ProjectTreeListDatas>[]);
      });
    }, _page, _id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
          child: ListView.separated(
              controller: _scroll_controller,
              padding: const EdgeInsets.all(16.0),
              itemBuilder: _renderRow,
              separatorBuilder: _separatorView,
              itemCount: _datas.length + 1),
          onRefresh: _getData),
    );
  }

  Widget _renderRow(BuildContext context, int index) {
    if (index < _datas.length) {
      return _itemView(context, index);
    }
    return _getMoreWidget();
  }

  Widget _separatorView(BuildContext context, int index) {
    return Container(
      height: 0.5,
      color: Colors.black26,
    );
  }

  Widget _itemView(BuildContext context, int index) {
    return InkWell(
      child: _newsRow(_datas[index]),
      onTap: () {
        _onItemClick(_datas[index]);
      },
    );
  }

  Widget _getMoreWidget() {
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

  _newsRow(ProjectTreeListDatas data) {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
          child: Image.network(
            data.envelopePic ?? '',
            width: 80,
            height: 120,
            fit: BoxFit.fill,
          ),
        ),
        Expanded(
            child: new Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Row(children: <Widget>[
                Expanded(
                    child: Text(
                  data.title ?? '',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ))
              ]),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    data.desc ?? '',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                    textAlign: TextAlign.left,
                    maxLines: 3,
                  ))
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Row(
                children: <Widget>[
                  Text(
                    data.author ?? '',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Expanded(
                      child: Text(
                    TimelineUtil.format(data.publishTime ?? 0),
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                    textAlign: TextAlign.right,
                  ))
                ],
              ),
            )
          ],
        ))
      ],
    );
  }

  void _onItemClick(ProjectTreeListDatas data) async {
    await Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return WebViewPageUI(
        title: data.title ?? '',
        url: data.link ?? '',
      );
    }));
  }
}
