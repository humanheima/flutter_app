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
  // ...existing code...
  //  TabController _tabControllerl;
  //
  //  var _tabsName = List<String>();
  List<String> _tabsName = <String>[];

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
        //        if (snapshot.data != null) {
        //          _parseWeChatCounts(snapshot.data);
        //          return Scaffold(
        //            appBar: AppBar(
        //              title: Text("公众号"),
        //              backgroundColor: Color.fromARGB(255, 119, 136, 213),
        //              centerTitle: true, //设置标题是否局中
        //            ),
        //            body: Column(
        //              children: <Widget>[
        //                TabBar(
        //                  indicatorColor: Colors.deepPurpleAccent,
        //                  labelColor: Colors.black87,
        //                  unselectedLabelColor: Colors.black45,
        //                  controller: _tabControllerl,
        //                  isScrollable: true,
        //                  tabs: _createTabs(),
        //                ),
        //                Expanded(
        //                  flex: 1,
        //                  child: TabBarView(
        //                    children: _createPages(snapshot.data),
        //                    controller: _tabControllerl,
        //                  ),
        //                )
        //              ],
        //            ),
        //          );
        //        }
        if (snapshot.data != null && snapshot.data.isNotEmpty) {
          _parseWeChatCounts(snapshot.data);
          // Use DefaultTabController so we don't need to manage lifecycle manually
          return DefaultTabController(
            length: _tabsName.length,
            child: Scaffold(
              appBar: AppBar(
                title: Text("公众号"),
                backgroundColor: Color.fromARGB(255, 119, 136, 213),
                centerTitle: true, //设置标题是否局中
                bottom: TabBar(
                  indicatorColor: Colors.deepPurpleAccent,
                  labelColor: Colors.black87,
                  unselectedLabelColor: Colors.black45,
                  isScrollable: true,
                  tabs: _createTabs(),
                ),
              ),
              body: TabBarView(
                children: _createPages(snapshot.data),
              ),
            ),
          );
        }
        // fallback when there's no data
        return Scaffold(
          appBar: AppBar(
            title: Text("公众号"),
            backgroundColor: Color.fromARGB(255, 119, 136, 213),
            centerTitle: true,
          ),
          body: Center(child: Text('暂无数据')),
        );
      },
    );
  }

  /// 网络请求 获取推荐微信公众号
  Future<List<WechatCount>> getWechatCount() async {
    try {
      Response response = await ApiManager().getWechatCount();
      if (response.data == null) return <WechatCount>[];
      return WechatCountBean.fromJson(response.data).data ?? <WechatCount>[];
    } catch (e) {
      // swallow and return empty list — caller handles empty state
      return <WechatCount>[];
    }
  }

  /// 解析微信公众号列表
  void _parseWeChatCounts(List<WechatCount> wxCounts) {
    _tabsName.clear();
    for (var value in wxCounts) {
      _tabsName.add(value.name ?? '');
    }
  }

  /// 生成顶部tab
  List<Widget> _createTabs() {
    List<Widget> widgets = <Widget>[];
    for (var value in _tabsName) {
      var tab = Tab(
        text: value,
      );
      widgets.add(tab);
    }
    return widgets;
  }

  /// 创建微信文章列表页
  List<Widget> _createPages(List<WechatCount> list) {
    List<Widget> widgets = <Widget>[];
    for (WechatCount count in list) {
      // count.id is int? in the model; WechatArticleListPage expects a non-null int.
      // Provide a default of 0 when id is null.
      var page = WechatArticleListPage(cid: count.id ?? 0);
      widgets.add(page);
    }
    return widgets;
  }
}
