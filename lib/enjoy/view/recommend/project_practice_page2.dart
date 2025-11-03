import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/enjoy/manager/api_manager.dart';
import 'package:flutter_app/enjoy/model/CategoryResponse.dart';
import 'package:flutter_app/enjoy/model/project_classify_bean.dart';
import 'package:flutter_app/enjoy/view/project_list_page.dart';
import 'package:flutter_app/enjoy/view/recommend/project_list_page2.dart';
import 'package:flutter_app/enjoy/widgets/async_snapshot_widget.dart';

///
/// Created by dumingwei on 2019/4/4.
/// Desc: 项目实践页
/// todo 使用这个改造
///

class ProjectPracticePage2 extends StatefulWidget {
  @override
  State createState() => _ProjectPracticePageState();
}

class _ProjectPracticePageState extends State<ProjectPracticePage2>
    with SingleTickerProviderStateMixin {
  // Use DefaultTabController instead of manual TabController
  List<String> _tabsName = <String>[];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: _buildFuture,
      future: getProjectClassify(),
    );
  }

  Widget _buildFuture(
      BuildContext context, AsyncSnapshot<List<RecCategory>> snapshot) {
    return AsyncSnapshotWidget(
      snapshot: snapshot,
      successWidget: (snapshot) {
        if (snapshot.data != null && snapshot.data.isNotEmpty) {
          _parseWeChatCounts(snapshot.data);
          return DefaultTabController(
            length: _tabsName.length,
            child: Scaffold(
              appBar: AppBar(
                title: Text('项目'),
                backgroundColor: Color.fromARGB(255, 119, 136, 213),
                centerTitle: true,
                bottom: TabBar(
                  indicatorColor: Colors.deepPurpleAccent,
                  labelColor: Colors.black87,
                  unselectedLabelColor: Colors.black45,
                  isScrollable: true,
                  tabs: _createTabs(),
                ),
              ),
              body: TabBarView(
                children: _createPages(snapshot.data),
              ),
            ),
          );
        }
        // fallback when no data
        //没有数据
        return Scaffold(
          appBar: AppBar(
            title: Text('项目'),
            backgroundColor: Color.fromARGB(255, 119, 136, 213),
            centerTitle: true,
          ),
          body: Center(child: Text('暂无数据')),
        );
      },
    );
  }

  /// 网络请求，获取项目分类
  Future<List<RecCategory>> getProjectClassify() async {
    try {
      //Response response = await ApiManager().getProjectClassify();

      Response response2 = await ApiManager().getRecCategoryList();
      CategoryData data = CategoryResponse.fromJson(response2.data).data;

      print("获取项目分类，response2:${data.toJsonString(pretty: true)}");
      return data.recCategoryList ?? <RecCategory>[];

    } catch (e) {
      print("获取项目分类 error $e");
      return <RecCategory>[];
    }
  }

  /// 解析项目列表
  void _parseWeChatCounts(List<RecCategory> projectClassify) {
    _tabsName.clear();
    for (var value in projectClassify) {
      _tabsName.add(value.category ?? '');
    }
  }

  /// 生成顶部tab
  List<Widget> _createTabs() {
    List<Widget> widgets = <Widget>[];
    for (var value in _tabsName) {
      var tab = Tab(
        text: value,
      );
      widgets.add(tab);
    }
    return widgets;
  }

  /// 创建项目列表页
  List<Widget> _createPages(List<RecCategory> projectClassify) {
    List<Widget> widgets = <Widget>[];
    for (RecCategory project in projectClassify) {
      //var page = ProjectListPage2(cid: project.id ?? 0);
      //widgets.add(page);
      var page = ProjectListPage2(cid: project.category);
      widgets.add(page);
    }
    return widgets;
  }
}
