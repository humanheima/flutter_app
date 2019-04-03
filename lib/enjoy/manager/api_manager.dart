import 'package:dio/dio.dart';

///
/// Created by dumingwei on 2019/4/2.
/// Desc:
///

class ApiManager {
  Dio _dio;

  static ApiManager _instance;

  ApiManager._internal() {
    var options = BaseOptions(
        baseUrl: "http://www.wanandroid.com/",
        connectTimeout: 10000,
        receiveTimeout: 3000);

    _dio = Dio(options);
  }

  factory ApiManager() => _getInstance();

  static ApiManager _getInstance() {
    if (_instance == null) {
      _instance = ApiManager._internal();
    }
    return _instance;
  }

  /// 获取首页Banner
  Future<Response> getHomeBanner() async {
    try {
      Response response = await _dio.get("banner/json");
      return response;
    } catch (e) {
      return null;
    }
  }

  /// 获取首页文章列表
  Future<Response> getHomeArticle(int page) async {
    try {
      Response response = await _dio.get('article/list/$page/json');
      return response;
    } catch (e) {
      return null;
    }
  }
}
