import 'package:flutter/material.dart';
import 'package:flutter_app/enjoy/model/project_list_bean.dart';
import 'package:flutter_app/enjoy/view/webview_page.dart';
import 'package:flutter_app/enjoy/constant/textsize_const.dart';

///
/// Created by dumingwei on 2019/4/4.
/// Desc:
///
/// 首页文章列表条目
class ProjectItem extends StatefulWidget {
  Project project;

  ProjectItem(this.project);

  @override
  State createState() {
    return _ProjectItemState();
  }
}

class _ProjectItemState extends State<ProjectItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (ctx) => WebViewPage(
                    title: widget.project.title, url: widget.project.link)));
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
                  image: widget.project.envelopePic),
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
                          widget.project.title,
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
                                  widget.project.author,
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
                            widget.project.desc,
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
                                widget.project.niceDate,
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
