import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/SearchPage.dart';
import 'package:flutter_app/models/SearchPageList.dart';
import 'package:flutter_app/models/WeixinPublicList.dart';
import 'package:flutter_app/wanandroid_flutter/api/Api.dart';

///
/// Created by dumingwei on 2019-10-18.
/// Desc:
///
class DioTest extends StatefulWidget {
  @override
  Widget build(BuildContext context) {}

  @override
  State createState() {
    return _DioTestState();
  }
}

class _DioTestState extends State<DioTest> {
  static Dio _dio = Dio();

  String responseJson = "请求响应";

  @override
  void initState() {
    _dio.interceptors.add(LogInterceptor());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('学习使用dio进行网络请求'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            color: Colors.grey[400],
            child: Text(responseJson),
          ),
          RaisedButton(
            child: Text('发起一个 GET 请求'),
            onPressed: () {
              _getWeixinPublicList();
            },
          ),
          RaisedButton(
            child: Text('发起一个 POST 请求'),
            onPressed: () {
              _search("flutter");
            },
          ),
        ],
      ),
    );
  }

  ///获取微信公众号列表
  void _getWeixinPublicList() async {
    Response response = await _dio.get(Api.WEIXIN_PUBLIC_LIST);
    WeixinPublicList publicList = WeixinPublicList.fromJson(response.data);
    for (var public in publicList.data) {
      print(public.toJson());
    }
    responseJson = publicList.data[0].toJson().toString();
    setState(() {});
  }

  ///搜索关键字
  void _search(String key) async {
    FormData formData = FormData.fromMap({
      "k": key,
    });
    Response response = await _dio.post(
      Api.SEARCH_LIST,
      data: formData,
    );
    SearchPageList pageList = SearchPageList.fromJson(response.data);
    SearchPage searchPage = pageList.data;
    for (var bean in searchPage.datas) {
      print(bean.toJson());
    }
    responseJson = searchPage.datas[0].toJson().toString();
    setState(() {});
  }
}
