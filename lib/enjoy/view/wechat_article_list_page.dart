import 'package:flutter/material.dart';
import 'package:flutter_app/enjoy/model/wechat_article_bean.dart';
import 'package:flutter_app/enjoy/manager/api_manager.dart';
import 'package:flutter_app/enjoy/widgets/item_wechat_article.dart';

///
/// Created by dumingwei on 2019/4/8.
/// Desc:   微信文章列表页
///

class WechatArticleListPage extends StatefulWidget {
  final int cid;

  WechatArticleListPage({required this.cid});

  @override
  State createState() => WechatArticleListPageState();
}

class WechatArticleListPageState extends State<WechatArticleListPage>
    with SingleTickerProviderStateMixin {
  int index = 1;
  List<Article> articles = <Article>[];

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
    try {
      final response = await ApiManager().getWechatArticle(widget.cid, index);
      final wechatArticleBean = WechatArticleBean.fromJson(response.data);
      // wechatArticleBean.data and data.datas can be null — provide empty list fallback
      final List<Article> newArticles = wechatArticleBean.data?.datas ?? <Article>[];

      if (newArticles.isNotEmpty) {
        setState(() {
          articles.addAll(newArticles);
        });
      }
    } catch (e) {
      // optionally log or handle error
    }
  }
}
