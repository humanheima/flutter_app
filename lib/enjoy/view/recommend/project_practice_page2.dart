import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/enjoy/manager/api_manager.dart';
import 'package:flutter_app/enjoy/model/CategoryResponse.dart';
import 'package:flutter_app/enjoy/view/recommend/project_list_page2.dart';

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

  List<RecCategory> categoryList = <RecCategory>[];

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //   builder: _buildFuture,
    //   future: getProjectClassify(),
    // );
    return DefaultTabController(
      length: categoryList.length,
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
          children: _createPages(categoryList),
        ),
      ),
    );
  }

  initState() {
    super.initState();
    getProjectClassify2();
  }

  /// 网络请求，获取项目分类
  Future<List<RecCategory>> getProjectClassify() async {
    try {
      Response response2 = await ApiManager().getRecCategoryList();
      CategoryData data = CategoryResponse.fromJson(response2.data).data;

      print("获取项目分类，response2:${data.toJsonString(pretty: true)}");
      return data.recCategoryList ?? <RecCategory>[];
    } catch (e) {
      print("获取项目分类 error $e");
      return <RecCategory>[];
    }
  }

  void getProjectClassify2() async {
    try {
      Response response2 = await ApiManager().getRecCategoryList();
      CategoryData data = CategoryResponse.fromJson(response2.data).data;

      print("获取项目分类，response2:${data.toJsonString(pretty: true)}");
      setState(() {
        categoryList = data.recCategoryList ?? <RecCategory>[];
      });
    } catch (e) {
      print("获取项目分类 error $e");
    }
  }

  /// 生成顶部tab
  List<Widget> _createTabs() {
    List<Widget> widgets = <Widget>[];
    for (var value in categoryList) {
      var tab = Tab(
        text: value.category,
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
