import 'package:dio/dio.dart';

///
/// Created by dumingwei on 2019/4/2.
/// Desc:
///

class ApiManager {
  late final Dio _dio;

  static final ApiManager _instance = ApiManager._internal();

  ApiManager._internal() {
    var options = BaseOptions(baseUrl: "https://www.wanandroid.com/");

    _dio = Dio(options);
  }

  factory ApiManager() => _instance;

  /// 获取首页Banner
  Future<Response<dynamic>> getHomeBanner() async {
    try {
      final response = await _dio.get("banner/json");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// 获取首页文章列表
  Future<Response<dynamic>> getHomeArticle(int page) async {
    try {
      final response = await _dio.get('article/list/$page/json');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// 获取项目分类
  Future<Response<dynamic>> getProjectClassify() async {
    try {
      final response = await _dio.get("project/tree/json");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// 获取项目列表
  Future<Response<dynamic>> getProjectList(int cid, int page) async {
    print("cid$cid");
    try {
      Response response = await _dio
          .get("project/list/$page/json", queryParameters: {"cid": "$cid"});
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// 获取推荐微信公众号
  Future<Response<dynamic>> getWechatCount() async {
    try {
      final response = await _dio.get("wxarticle/chapters/json");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// 获取微信文章列表
  Future<Response<dynamic>> getWechatArticle(int cid, int page) async {
    try {
      final response = await _dio.get("wxarticle/list/${cid}/${page}/json");
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
