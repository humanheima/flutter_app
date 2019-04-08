import 'package:flutter/material.dart';
import 'package:flutter_app/enjoy/model/project_list_bean.dart';
import 'package:flutter_app/enjoy/manager/api_manager.dart';
import 'package:flutter_app/enjoy/widgets/item_project.dart';

///
/// Created by dumingwei on 2019/4/4.
/// Desc: 项目列表页
///

class ProjectListPage extends StatefulWidget {
  int cid = 0;

  ProjectListPage({this.cid});

  @override
  State createState() {
    return _ProjectListState();
  }
}

class _ProjectListState extends State<ProjectListPage>
    with AutomaticKeepAliveClientMixin {
  int index = 1;

  List<Project> projects = List();

  @override
  void initState() {
    super.initState();
    getList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int position) {
        return ProjectItem(projects[position]);
      },
      itemCount: projects.length,
    );
  }

  /// 获取项目列表
  void getList() async {
    await ApiManager().getProjectList(widget.cid, index).then((response) {
      if (response != null) {
        var projectListBean = ProjectListBean.fromJson(response.data);
        setState(() {
          projects.addAll(projectListBean.data.datas);
        });
      }
    });
  }

  @override
  bool get wantKeepAlive => true;
}
