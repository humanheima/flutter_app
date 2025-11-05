import 'package:dio/dio.dart';

///
/// Created by dumingwei on 2019/4/13.
/// Desc:
///

class DioManager {
  // Make non-nullable and initialize via initializer list
  final Dio _dio;

  DioManager._internal() : _dio = Dio();

  static DioManager singleton = DioManager._internal();

  factory DioManager() => singleton;

  Dio getDio() {
    return _dio;
  }
}
