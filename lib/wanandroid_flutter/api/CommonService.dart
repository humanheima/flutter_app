import 'package:dio/dio.dart';
import 'package:flutter_app/wanandroid_flutter/common/User.dart';
import 'package:flutter_app/wanandroid_flutter/model/ArticleModel.dart';
import 'package:flutter_app/wanandroid_flutter/model/BannerModel.dart';
import 'package:flutter_app/wanandroid_flutter/model/NaviModel.dart';
import 'package:flutter_app/wanandroid_flutter/model/ProjectListModel.dart';
import 'package:flutter_app/wanandroid_flutter/model/ProjectTreeModel.dart';
import 'package:flutter_app/wanandroid_flutter/model/SystemTreeContentModel.dart';
import 'package:flutter_app/wanandroid_flutter/model/SystemTreeModel.dart';
import 'package:flutter_app/wanandroid_flutter/model/UserModel.dart';
import 'package:flutter_app/wanandroid_flutter/model/WxArticleContentModel.dart';
import 'package:flutter_app/wanandroid_flutter/model/WxArticleTitleModel.dart';
import 'package:flutter_app/wanandroid_flutter/net/DioManager.dart';

import 'Api.dart';

///
/// Created by dumingwei on 2019/4/13.
/// Desc:
///

class CommonService {
  void getArticleList(Function callback, int _page) async {
    DioManager.singleton
        .getDio()
        .get(Api.HOME_ARTICLE_LIST + "$_page/json", options: _getOptions())
        .then((response) {
      callback(ArticleModel(response.data));
    });
  }

  ///获取知识体系
  void getSystemTree(Function callback) async {
    DioManager.singleton
        .getDio()
        .get(Api.SYSTEM_TREE, options: _getOptions())
        .then((response) {
      callback(SystemTreeModel(response.data));
    });
  }

  ///获取知识体系列表详情
  void getSystemTreeContent(Function callback, int _page, int _id) async {
    DioManager.singleton
        .getDio()
        .get(Api.SYSTEM_TREE_CONTENT + "$_page/json?cid=$_id",
            options: _getOptions())
        .then((response) {
      callback(SystemTreeContentModel(response.data));
    });
  }

  ///获取公众号名称
  void getWxList(Function callback) async {
    DioManager.singleton
        .getDio()
        .get(Api.WX_LIST, options: _getOptions())
        .then((response) {
      callback(WxArticleTitleModel(response.data));
    });
  }

  ///获取公众号文章
  void getWxArticleList(Function callback, int _id, int _page) async {
    DioManager.singleton
        .getDio()
        .get(Api.WX_ARTICLE_LIST + "$_id/$_page/json", options: _getOptions())
        .then((response) {
      callback(WxArticleContentModel(response.data));
    });
  }

  ///获取导航列表数据
  void getNaviList(Function callback) async {
    DioManager.singleton
        .getDio()
        .get(Api.NAVI_LIST, options: _getOptions())
        .then((response) {
      print('getNaviList${response.data}');
      callback(NaviModel(response.data));
    });
  }

  ///获取项目分类
  void getProjectTree(Function callback) async {
    DioManager.singleton
        .getDio()
        .get(Api.PROJECT_TREE, options: _getOptions())
        .then((response) {
      print('getProjectTree${response.data}');
      callback(ProjectTreeModel(response.data));
    });
  }

  ///获取项目列表
  void getProjectList(Function callback, int _page, int _id) async {
    DioManager.singleton
        .getDio()
        .get(Api.PROJECT_LIST + "$_page/json?cid=$_id", options: _getOptions())
        .then((response) {
      print('getProjectList${response.data}');
      callback(ProjectTreeListModel(response.data));
    });
  }

  ///注册
  void register(Function callback, String _username, String _password) async {
    FormData formData = FormData.from({
      "username": _username,
      "password": _password,
      "repassword": _password
    });
    DioManager.singleton
        .getDio()
        .post(Api.USER_REGISTER, data: formData, options: null)
        .then((response) {
      print('register${response.data}');
      callback(UserModel(response.data));
    });
  }

  ///登录
  void login(Function callback, String _username, String _password) async {
    FormData formData =
        FormData.from({"username": _username, "password": _password});
    DioManager.singleton
        .getDio()
        .post(Api.USER_LOGIN, data: formData, options: null)
        .then((response) {
      print('register${response.data}');
      callback(UserModel(response.data), response);
    });
  }

  void getBanner(Function callback) async {
    DioManager.singleton
        .getDio()
        .get(Api.HOME_BANNER, options: _getOptions())
        .then((response) {
      callback(BannerModel(response.data));
    });
  }

  Options _getOptions() {
    Map<String, String> map = new Map();
    List<String> cookies = User().cookie;
    map['Cookie'] = cookies.toString();
    return Options(headers: map);
  }
}
