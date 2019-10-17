import 'package:flutter/material.dart';
import 'package:flutter_app/enjoy_android/model/wechat_article_bean.dart';
import 'package:flutter_app/enjoy_android/manager/api_manager.dart';
import 'package:flutter_app/enjoy_android/widgets/item_wechat_article.dart';

///
/// Created by dumingwei on 2019/4/8.
/// Desc:   微信文章列表页
///

class WechatArticleListPage extends StatefulWidget {
  int cid = 0;

  WechatArticleListPage({this.cid});

  @override
  State createState() => WechatArticleListPageState();
}

class WechatArticleListPageState extends State<WechatArticleListPage>
    with SingleTickerProviderStateMixin {
  int index = 1;
  List<Article> articles = List();

  @override
  void initState() {
    super.initState();
    getList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return WechatArticleItem(article: articles[index]);
      },
      itemCount: articles.length,
    );
  }

  /// 网络请求，获取微信文章列表
  void getList() async {
    await ApiManager().getWechatArticle(widget.cid, index).then((response) {
      if (response != null) {
        var wechatArticleBean = WechatArticleBean.fromJson(response.data);

        setState(() {
          articles.addAll(wechatArticleBean.data.datas);
        });
      }
    });
  }
}
