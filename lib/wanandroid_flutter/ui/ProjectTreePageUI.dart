import 'package:flutter/material.dart';

///
/// Created by dumingwei on 2019/4/13.
/// Desc:
///

class ProjectTreePageUI extends StatefulWidget {
  @override
  State createState() => ProjectTreePageUIState();
}

class ProjectTreePageUIState extends State<ProjectTreePageUI>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(
        "动画基本结构",
        style: new TextStyle(fontSize: 20, color: Colors.redAccent),
      ),
      onPressed: () {},
    );
  }

  @override
  bool get wantKeepAlive {
    return true;
  }
}
