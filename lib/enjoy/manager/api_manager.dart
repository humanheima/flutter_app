import 'package:dio/dio.dart';

///
/// Created by dumingwei on 2019/4/2.
/// Desc:
///

class ApiManager {
  late final Dio _dio;

  // Dio instance for the dream API which uses a different baseUrl
  late final Dio _dreamDio;

  // Configure the dream API base URL here (adjust to real endpoint)
  //static const String _dreamBaseUrl = "https://test-app.zhumengdao.com/";
  static const String _dreamBaseUrl = "https://pre-app.zhumengdao.com/";

  static final ApiManager _instance = ApiManager._internal();

  ApiManager._internal() {
    var options = BaseOptions(baseUrl: "https://www.wanandroid.com/");

    _dio = Dio(options);

    // Initialize a separate Dio for the dream API so it can use a different baseUrl
    var dreamOptions = BaseOptions(baseUrl: _dreamBaseUrl);
    _dreamDio = Dio(dreamOptions);
  }

  factory ApiManager() => _instance;

  /// 获取分类列表
  /// https://test-app.zhumengdao.com/im/rec/square/recCategoryList
  Future<Response<dynamic>> getRecCategoryList() async {
    try {
      // Use the dream-specific Dio instance so this request goes to a different baseUrl
      final response = await _dreamDio.get("im/rec/square/recCategoryList");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// 获取推荐人物发现页
  ///
  /// 参数说明：
  /// - sort: 排序类型（字符串），默认空
  /// - tagName: 筛选标签，默认空
  /// - recPageNum: 推荐页码，默认 0
  /// - pageSize: 每页大小，可选，默认 20
  /// - extraQuery: 额外的 query 参数，会合并到请求中（优先级更高）
  ///
  /// /xxsy/im/characterDiscovery/square?sort=&tagName=&recPageNum=0
  Future<Response<dynamic>> getCharacterDiscovery({
    String sort = '',
    String tagName = '',
    int recPageNum = 0,
    int pageSize = 20,
    Map<String, dynamic>? extraQuery,
  }) async {
    try {
      final query = <String, dynamic>{
        'sort': sort,
        'tagName': tagName,
        'recPageNum': recPageNum,
        'pageSize': pageSize,
      };

      if (extraQuery != null) {
        query.addAll(extraQuery);
      }

      // Use the dream-specific Dio instance so this request goes to a different baseUrl
      final response = await _dreamDio.get(
        'xxsy/im/characterDiscovery/square',
        queryParameters: query,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

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
