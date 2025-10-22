import 'package:flutter/material.dart';
import 'package:flutter_app/enjoy/constant/textsize_const.dart';
import 'package:flutter_app/enjoy/model/home_article_bean.dart';
import 'package:flutter_app/enjoy/view/webview_page.dart';

///
/// Created by dumingwei on 2019/4/3.
/// Desc: 首页文章的item
///

class HomeArticleItem extends StatefulWidget {
  final Article article;

  HomeArticleItem(this.article);

  @override
  State createState() => _HomeArticleItemState();
}

class _HomeArticleItemState extends State<HomeArticleItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
          return WebViewPage(url: widget.article.link ?? "", title: widget.article.title ?? "");
        }));
      },
      child: Card(
        margin: EdgeInsets.fromLTRB(2, 5, 2, 0),
        child: Container(
          padding: EdgeInsets.fromLTRB(18, 10, 18, 10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.child_care,
                    color: Colors.blueAccent,
                    size: 18,
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        widget.article.author ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                    (widget.article.title ?? "")
                        .replaceAll("&rdquo;", "")
                        .replaceAll("&ldquo;", ""),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: TextSizeConst.middleTextSize),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.access_time,
                    color: Colors.grey,
                    size: 15,
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        widget.article.niceDate ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
