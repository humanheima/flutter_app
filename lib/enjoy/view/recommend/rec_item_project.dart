import 'package:flutter/material.dart';
import 'package:flutter_app/enjoy/constant/textsize_const.dart';
import 'package:flutter_app/enjoy/model/HomeResponse.dart';
import 'package:flutter_app/enjoy/view/webview_page.dart';

///
/// Created by dumingwei on 2019/4/4.
/// Desc:
///
/// 首页文章列表条目
class RecProjectItem extends StatefulWidget {
  final Character project;

  RecProjectItem(this.project);

  @override
  State createState() {
    return _RecProjectItemState();
  }
}

class _RecProjectItemState extends State<RecProjectItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => WebViewPage(
                    title: widget.project.name ?? "",
                    url: widget.project.qurl ?? "")));
      },
      child: Card(
        margin: EdgeInsets.fromLTRB(2, 5, 2, 0),
        child: Container(
          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: Row(
            children: <Widget>[
              FadeInImage.assetNetwork(
                  width: 120,
                  height: 240,
                  placeholder: "images/image_default.png",
                  imageErrorBuilder: (_, __, ___) {
                    return Image.asset(
                      "images/image_default.png",
                      width: 120,
                      height: 240,
                      fit: BoxFit.fitWidth,
                    );
                  },
                  fit: BoxFit.fitWidth,
                  image: widget.project.avatar ?? ""),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: 240,
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.project.name ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: TextSizeConst.middleTextSize),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.child_care,
                              color: Colors.grey,
                              size: 16,
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  widget.project.identity ?? "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            widget.project.otherSetting ?? "",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.orange,
                                fontSize: TextSizeConst.smallTextSize),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.access_time,
                              color: Colors.grey,
                              size: 15,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                widget.project.identity ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
