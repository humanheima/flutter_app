import 'package:flutter/material.dart';
import 'package:flutter_app/enjoy/manager/api_manager.dart';
import 'package:flutter_app/enjoy/view/recommend/rec_item_project.dart';
import 'package:flutter_app/enjoy/widgets/item_project.dart';

import '../../model/HomeResponse.dart';

///
/// Created by dumingwei on 2019/4/4.
/// Desc: 项目列表页
///

class ProjectListPage2 extends StatefulWidget {
  final String cid;

  //final String cid;

  ProjectListPage2({this.cid = "0"});

  @override
  State createState() {
    return _ProjectListState();
  }
}

class _ProjectListState extends State<ProjectListPage2>
    with AutomaticKeepAliveClientMixin {
  // 筛选的标签名
  String? tagName;

  // 筛选的排序方式
  String? sortType;

  // 页码（从1开始）
  int pageNum = 0;

  List<Character> projects = <Character>[];

  @override
  void initState() {
    super.initState();
    getList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      itemBuilder: (BuildContext context, int position) {
        return RecProjectItem(projects[position]);
      },
      itemCount: projects.length,
    );
  }

  /// 获取项目列表
  void getList() async {
    // 使用新的 getCharacterDiscovery 接口，传入分页和筛选参数
    try {
      final response = await ApiManager().getCharacterDiscovery(
          sort: sortType ?? '', tagName: tagName ?? '', recPageNum: pageNum);

      var homeResponse = HomeResponse.fromJson(response.data);

      var projectListBean = homeResponse.data.character?.list ?? <Character>[];

      setState(() {
        projects.addAll(projectListBean);
        // 下一页
        pageNum += 1;
      });
    } catch (e) {
      // 可以在此处理错误或提示用户
      rethrow;
    }
  }

  @override
  bool get wantKeepAlive => true;
}
