import 'package:flutter/material.dart';
import 'package:flutter_app/wanandroid_flutter/api/CommonService.dart';
import 'package:flutter_app/wanandroid_flutter/model/WxArticleContentModel.dart';
import 'package:flutter_app/wanandroid_flutter/model/WxArticleTitleModel.dart';
import 'package:flutter_app/wanandroid_flutter/utils/RouteUtil.dart';
import 'package:flutter_app/wanandroid_flutter/utils/timeline_util.dart';

///
/// Created by dumingwei on 2019/4/13.
/// Desc:
///

class WxArticlePageUI extends StatefulWidget {
  @override
  State createState() {
    return WxArticlePageUIState();
  }
}

class WxArticlePageUIState extends State<WxArticlePageUI>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  List<WxArticleTitleData> _datas = [];

  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    _tabController = TabController(length: _datas.length, vsync: this);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.4,
        title: TabBar(
          tabs: _datas.map((WxArticleTitleData item) {
            return Tab(
              text: item.name,
            );
          }).toList(),
          isScrollable: true,
          controller: _tabController,
        ),
      ),
      body: TabBarView(
          controller: _tabController,
          children: _datas.map((item) {
            return NewsList(id: item.id);
          }).toList()),
    );
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  Future<Null> _getData() async {
    CommonService().getWxList((WxArticleTitleModel response) {
      setState(() {
        _datas = response.data ?? [];
      });
    });
  }

  @override
  bool get wantKeepAlive {
    return true;
  }
}

class NewsList extends StatefulWidget {
  final int? id;

  NewsList({Key? key, this.id}) : super(key: key);

  @override
  State createState() {
    return _NewsListState();
  }
}

class _NewsListState extends State<NewsList> {
  List<WxArticleContentDatas> _datas = [];

  ScrollController _scrollController = ScrollController();

  int _page = 1;

  @override
  void initState() {
    super.initState();
    _getData();
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
          child: ListView.builder(
            itemBuilder: _renderRow,
            itemCount: _datas.length + 1,
            padding: const EdgeInsets.all(16.0),
            controller: _scrollController,
          ),
          onRefresh: _getData),
    );
  }

  Future<Null> _getData() async {
    _page = 1;
    int _id = widget.id ?? 0;
    CommonService().getWxArticleList((WxArticleContentModel response) {
      setState(() {
        _datas = response.data?.datas ?? [];
      });
    }, _id, _page);
  }

  Future<Null> _getMore() async {
    _page++;
    int _id = widget.id ?? 0;
    CommonService().getWxArticleList((WxArticleContentModel response) {
      setState(() {
        _datas.addAll(response.data?.datas ?? []);
      });
    }, _id, _page);
  }

  Widget _renderRow(BuildContext context, int index) {
    if (index < _datas.length) {
      return _newsRow(_datas[index]);
    }
    return _getMoreWidget();
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

  Widget _newsRow(WxArticleContentDatas item) {
    return InkWell(
      onTap: () {
        RouteUtil.toWebView(context, item.title ?? '', item.link ?? '');
      },
      child: Card(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    item.title ?? '',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ))
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                      child: Text(TimelineUtil.format(item.publishTime),
                          style: TextStyle(fontSize: 12, color: Colors.grey)))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
