import 'package:flutter/material.dart';
import 'package:flutter_app/wanandroid_flutter/api/CommonService.dart';
import 'package:flutter_app/wanandroid_flutter/model/ArticleModel.dart';
import 'package:flutter_app/wanandroid_flutter/utils/timeline_util.dart';
import 'package:flutter_app/wanandroid_flutter/widget/BannerWidgetUI.dart';
import 'package:flutter_app/wanandroid_flutter/utils/RouteUtil.dart';

///
/// Created by dumingwei on 2019/4/13.
/// Desc:
///

class HomePageUI extends StatefulWidget {
  @override
  State createState() {
    return HomePageUIState();
  }
}

class HomePageUIState extends State<HomePageUI>
    with AutomaticKeepAliveClientMixin {
  List<Article> _datas = <Article>[];
  ScrollController _scrollController = ScrollController();
  int _page = 0; //加载页数

  @override
  void initState() {
    super.initState();
    getData();
    _scroll_controller_add_listener();
  }

  void _scroll_controller_add_listener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('滑动到了底部');
        _getMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // for AutomaticKeepAliveClientMixin
    return Scaffold(
      body: RefreshIndicator(
          child: ListView.separated(
              itemBuilder: _renderRow,
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  height: 0.5,
                  color: Colors.black26,
                );
              },
              controller: _scrollController,
              //多的两个item一个是顶部banner，一个是底部的loadmore
              itemCount: _datas.length + 2),
          onRefresh: getData),
      //drawer: DrawerWidgetUI(),
    );
  }

  @override
  bool get wantKeepAlive {
    return true;
  }

  Future<void> getData() async {
    _page = 0;
    print('$_page');
    CommonService().getArticleList((ArticleModel _articleModel) {
      setState(() {
        _datas = _articleModel.data?.datas ?? <Article>[];
      });
    }, _page);
  }

  Future<void> _getMore() async {
    _page++;
    print("$_page");

    CommonService().getArticleList((ArticleModel _articleModel) {
      setState(() {
        _datas.addAll(_articleModel.data?.datas ?? <Article>[]);
      });
    }, _page);
  }

  Widget _renderRow(BuildContext context, int index) {
    if (index == 0) {
      return Container(
        height: 200,
        color: Colors.purple,
        child: BannerWidgetUI(),
      );
    }
    if (index - 1 < _datas.length) {
      return InkWell(
        onTap: () {
          print("title");
          print("link");
          RouteUtil.toWebView(
              context, _datas[index - 1].title ?? '', _datas[index - 1].link ?? '');
        },
        child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  children: <Widget>[
                    Text(
                      _datas[index - 1].author ?? '',
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.left,
                    ),
                    Expanded(
                        child: Text(
                      TimelineUtil.format(_datas[index - 1].publishTime ?? 0),
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 12),
                    )),
                  ],
                )),
            Container(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      _datas[index - 1].title ?? '',
                      maxLines: 2,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ))
                  ],
                )),
            Container(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Row(
                  children: <Widget>[
                    Text(
                      _datas[index - 1].superChapterName ?? '',
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.left,
                    ),
                  ],
                )),
          ],
        ),
      );
    }

    return _getMoreWidget();
  }

  /// 加载更多时显示的组件,给用户提示
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
