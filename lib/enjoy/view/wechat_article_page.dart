import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/enjoy/manager/api_manager.dart';
import 'package:flutter_app/enjoy/model/wechat_count_bean.dart';
import 'package:flutter_app/enjoy/widgets/async_snapshot_widget.dart';
import 'package:flutter_app/enjoy/view/wechat_article_list_page.dart';

///
/// Created by dumingwei on 2019/4/8.
/// Desc: 微信公众号页面
///

class WechatArticlePage extends StatefulWidget {
  @override
  State createState() {
    return _WechatArticlePageState();
  }
}

class _WechatArticlePageState extends State<WechatArticlePage>
    with SingleTickerProviderStateMixin {
  TabController _tabControllerl;

  var _tabsName = List<String>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: _buildFuture,
      future: getWechatCount(),
    );
  }

  Widget _buildFuture(
      BuildContext context, AsyncSnapshot<List<WechatCount>> snapshot) {
    return AsyncSnapshotWidget(
      snapshot: snapshot,
      successWidget: (snapshot) {
        if (snapshot.data != null) {
          _parseWeChatCounts(snapshot.data);
          if (_tabControllerl == null) {
            _tabControllerl = TabController(
                length: snapshot.data.length, vsync: this, initialIndex: 0);
          }
          return Scaffold(
            appBar: AppBar(
              title: Text("公众号"),
              backgroundColor: Color.fromARGB(255, 119, 136, 213),
              centerTitle: true, //设置标题是否局中
            ),
            body: Column(
              children: <Widget>[
                TabBar(
                  indicatorColor: Colors.deepPurpleAccent,
                  labelColor: Colors.black87,
                  unselectedLabelColor: Colors.black45,
                  controller: _tabControllerl,
                  isScrollable: true,
                  tabs: _createTabs(),
                ),
                Expanded(
                  flex: 1,
                  child: TabBarView(
                    children: _createPages(snapshot.data),
                    controller: _tabControllerl,
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }

  /// 网络请求 获取推荐微信公众号
  Future<List<WechatCount>> getWechatCount() async {
    Response response;
    await ApiManager().getWechatCount().then((res) {
      response = res;
    });
    return WechatCountBean.fromJson(response.data).data;
  }

  /// 解析微信公众号列表
  void _parseWeChatCounts(List<WechatCount> wxCounts) {
    _tabsName.clear();
    for (var value in wxCounts) {
      _tabsName.add(value.name);
    }
  }

  /// 生成顶部tab
  List<Widget> _createTabs() {
    List<Widget> widgets = List();
    for (var value in _tabsName) {
      var tab = Tab(
        text: value,
      );
      widgets.add(tab);
    }
    return widgets;
  }

  /// 创建微信文章列表页
  _createPages(List<WechatCount> list) {
    List<Widget> widgets = List();
    for (WechatCount count in list) {
      var page = WechatArticleListPage(cid: count.id);
      widgets.add(page);
    }
    return widgets;
  }
}
