import 'package:flutter/material.dart';
import 'package:flutter_app/enjoy/model/wechat_article_bean.dart';
import 'package:flutter_app/enjoy/view/webview_page.dart';
import 'package:flutter_app/enjoy/constant/textsize_const.dart';

///
/// Created by dumingwei on 2019/4/8.
/// Desc:  微信文章列表条目
///

class WechatArticleItem extends StatefulWidget {
  final Article article;

  WechatArticleItem({required this.article});

  @override
  State createState() {
    return WechatArticleItemState();
  }
}

class WechatArticleItemState extends State<WechatArticleItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (ctx) => WebViewPage(
                    title: widget.article.title ?? "", url: widget.article.link ?? "")));
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: new Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
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
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
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
                      ))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
            ),
            Container(
              color: Colors.grey,
              height: 0.5,
            )
          ],
        ),
      ),
    );
  }
}
