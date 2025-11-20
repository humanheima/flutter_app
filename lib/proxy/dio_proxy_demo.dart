import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_proxy_native/flutter_proxy_native.dart';

/// Dio 代理设置 Demo
/// 演示如何获取 Android 系统代理并设置给 Dio 进行抓包
class DioProxyDemo extends StatefulWidget {
  const DioProxyDemo({Key? key}) : super(key: key);

  @override
  State<DioProxyDemo> createState() => _DioProxyDemoState();
}

class _DioProxyDemoState extends State<DioProxyDemo> {
  final Dio _dio = Dio();
  String _proxyInfo = '未检测';
  String _requestResult = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _setupDioProxy();
  }

  /// 设置 Dio 代理
  void _setupDioProxy() async {
    // 获取系统代理配置
    final proxyHost = Platform.environment['HTTP_PROXY'] ??
        Platform.environment['http_proxy'];

    final _flutterProxyPlugin = FlutterProxyNative();

    var proxy = await _flutterProxyPlugin.getSystemProxy() ?? '';

    print("DioProxyDemo - 系统代理: $proxy");

    if (proxy != null) {
      setState(() {
        _proxyInfo = '系统代理: $proxy';
      });

      // 配置 Dio 使用代理
      (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
        final client = HttpClient();

        // 设置代理
        client.findProxy = (uri) {
          return 'PROXY $proxy';
        };

        // 如果是 HTTPS 抓包工具（如 Charles、Fiddler），需要允许自签名证书
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;

        return client;
      };
    } else {
      // 手动设置代理（用于开发测试）
      // 例如：电脑运行 Charles，手机连接同一 WiFi
      // 电脑 IP: 192.168.1.100, Charles 端口: 8888
      const manualProxy = '192.168.1.100:8888'; // 根据实际情况修改

      setState(() {
        _proxyInfo = '未检测到系统代理，可手动设置:\n$manualProxy（已注释）';
      });

      // 取消注释以下代码来手动设置代理
      /*
      (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
        final client = HttpClient();
        client.findProxy = (uri) {
          return 'PROXY $manualProxy';
        };
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
      setState(() {
        _proxyInfo = '手动设置代理: $manualProxy';
      });
      */
    }

    // 配置 Dio 基础选项
    _dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'User-Agent': 'DioProxyDemo/1.0',
      },
    );

    // 添加拦截器以便查看请求和响应
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint('===> 请求 [${options.method}] ${options.uri}');
          debugPrint('===> Headers: ${options.headers}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint(
              '<== 响应 [${response.statusCode}] ${response.requestOptions.uri}');
          return handler.next(response);
        },
        onError: (error, handler) {
          debugPrint(
              '<=== 错误 [${error.response?.statusCode}] ${error.requestOptions.uri}');
          debugPrint('<=== 错误信息: ${error.message}');
          return handler.next(error);
        },
      ),
    );
  }

  /// 执行测试请求
  Future<void> _makeTestRequest() async {
    setState(() {
      _isLoading = true;
      _requestResult = '请求中...';
    });

    try {
      // 测试请求 - 使用一个公开的 API
      final response = await _dio.get('https://api.github.com/users/flutter');

      setState(() {
        _requestResult = '✅ 请求成功!\n'
            '状态码: ${response.statusCode}\n'
            '用户名: ${response.data['login']}\n'
            '名称: ${response.data['name']}\n'
            '粉丝数: ${response.data['followers']}\n\n'
            '💡 如果配置了代理，现在可以在抓包工具中看到请求详情了！';
      });
    } on DioException catch (e) {
      setState(() {
        _requestResult = '❌ 请求失败!\n'
            '错误类型: ${e.type}\n'
            '错误信息: ${e.message}\n\n'
            '${_getErrorTip(e)}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// 获取错误提示
  String _getErrorTip(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return '💡 提示: 请检查代理服务器是否正常运行';
      case DioExceptionType.badCertificate:
        return '💡 提示: SSL 证书验证失败，请确认代理工具的证书配置';
      case DioExceptionType.connectionError:
        return '💡 提示: 连接失败，请检查:\n'
            '1. 代理服务器地址和端口是否正确\n'
            '2. 手机和电脑是否在同一网络\n'
            '3. 代理服务器是否允许外部连接';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dio 代理抓包 Demo'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 代理信息卡片
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.settings_ethernet, color: Colors.blue),
                        SizedBox(width: 8),
                        Text(
                          '代理配置信息',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _proxyInfo,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 使用说明
            Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '📱 使用说明',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '1. 在电脑上启动抓包工具（Charles/Fiddler/mitmproxy）\n'
                      '2. 确保手机和电脑在同一 WiFi 网络\n'
                      '3. 在手机 WiFi 设置中配置代理:\n'
                      '   - 主机名: 电脑的 IP 地址\n'
                      '   - 端口: 抓包工具的端口（如 8888）\n'
                      '4. 如需抓取 HTTPS，需在手机安装证书\n'
                      '5. 点击下方按钮发送测试请求',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // 测试按钮
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: _isLoading ? null : _makeTestRequest,
                icon: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.send),
                label: Text(_isLoading ? '请求中...' : '发送测试请求'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // 请求结果
            if (_requestResult.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.receipt_long, color: Colors.green),
                          SizedBox(width: 8),
                          Text(
                            '请求结果',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _requestResult,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _dio.close();
    super.dispose();
  }
}
