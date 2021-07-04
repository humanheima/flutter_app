import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/enjoy_android/manager/api_manager.dart';
import 'package:flutter_app/enjoy_android/model/project_classify_bean.dart';
import 'package:flutter_app/enjoy_android/widgets/async_snapshot_widget.dart';
import 'package:flutter_app/enjoy_android/view/project_list_page.dart';

///
/// Created by dumingwei on 2019/4/4.
/// Desc: 项目实践页
///

class ProjectPracticePage extends StatefulWidget {
  @override
  State createState() => _ProjectPracticePageState();
}

class _ProjectPracticePageState extends State<ProjectPracticePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  var _tabsName = List<String>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: _buildFuture,
      future: getProjectClassify(),
    );
  }

  Widget _buildFuture(
      BuildContext context, AsyncSnapshot<List<ProjectClassify>> snapshot) {
    return AsyncSnapshotWidget(
      snapshot: snapshot,
      successWidget: (snapshot) {
        if (snapshot.data != null) {
          _parseWeChatCounts(snapshot.data);
          if (_tabController == null) {
            _tabController = TabController(
                length: snapshot.data.length, vsync: this, initialIndex: 0);
          }
          return Scaffold(
            appBar: AppBar(
              title: Text('项目'),
              backgroundColor: Color.fromARGB(255, 119, 136, 213),
              centerTitle: true,
            ),
            body: Column(
              children: <Widget>[
                TabBar(
                  indicatorColor: Colors.deepPurpleAccent,
                  labelColor: Colors.black87,
                  unselectedLabelColor: Colors.black45,
                  controller: _tabController,
                  isScrollable: true,
                  tabs: _createTabs(),
                ),
                Expanded(
                  flex: 1,
                  child: TabBarView(
                    children: _createPages(snapshot.data),
                    controller: _tabController,
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }

  /// 网络请求，获取项目分类
  Future<List<ProjectClassify>> getProjectClassify() async {
    try {
      Response response;
      response = await ApiManager().getProjectClassify();
      return ProjectClassifyBean.fromJson(response.data).data;
    } catch (e) {
      return null;
    }
  }

  /// 解析项目列表
  void _parseWeChatCounts(List<ProjectClassify> projectClassify) {
    _tabsName.clear();
    for (var value in projectClassify) {
      _tabsName.add(value.name);
    }
  }

  /// 生成顶部tab
  List<Widget> _createTabs() {
    List<Widget> widgets = List();
    for (var value in _tabsName) {
      var tab = Tab(
        text: value,
      );
      widgets.add(tab);
    }
    return widgets;
  }

  /// 创建项目列表页
  List<Widget> _createPages(List<ProjectClassify> projectClassify) {
    List<Widget> widgets = List();
    for (ProjectClassify project in projectClassify) {
      var page = ProjectListPage(cid: project.id);
      widgets.add(page);
    }
    return widgets;
  }
}
