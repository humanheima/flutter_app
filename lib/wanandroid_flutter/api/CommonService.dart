import 'package:dio/dio.dart';
import 'package:flutter_app/wanandroid_flutter/common/User.dart';
import 'package:flutter_app/wanandroid_flutter/model/ArticleModel.dart';
import 'package:flutter_app/wanandroid_flutter/model/BannerModel.dart';
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
