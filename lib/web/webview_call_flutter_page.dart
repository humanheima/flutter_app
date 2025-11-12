import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// WebView调用Flutter调试工具页面
///
/// ## 🎯 主要用途
/// 专门用于测试和诊断 **WebView → Flutter** 的通信功能的调试工具。
///
/// ## 🔧 具体功能
///
/// ### WebView 端（JavaScript）测试按钮：
/// - `testBasicCall()` - 测试基础调用（无返回值）
/// - `testCallWithReturn()` - 测试带返回值调用
/// - `testDeviceInfo()` - 测试获取设备信息
/// - `checkCommunication()` - 检查通信方式可用性
/// - `clearLog()` - 清空调试日志
///
/// ### Flutter 端（Dart）支持的方法：
/// - `showToast` - 显示 Toast 消息
/// - `getUserInfo` - 获取用户信息（模拟数据）
/// - `getDeviceInfo` - 获取真实设备信息
///
/// ## 🛠️ 通信机制测试
/// 1. **JavaScriptChannel** - 主要通信方式
/// 2. **自定义URL协议** - 备用通信方式
/// 3. **带返回值处理** - 测试异步回调机制
/// 4. **详细日志记录** - 帮助诊断问题
///
/// ## 📱 调试特性
/// - **实时日志显示** - 在WebView页面内显示操作日志
/// - **通信方式检测** - 自动检测可用的通信方式
/// - **错误诊断** - 捕获和显示通信错误
/// - **超时处理** - 测试长时间调用的处理
///
/// ## 使用场景
/// - WebView通信问题调试
/// - 带返回值调用超时诊断
/// - 通信机制兼容性测试
/// - JavaScript与Flutter交互验证
class WebViewCallFlutterPage extends StatefulWidget {
  const WebViewCallFlutterPage({Key? key}) : super(key: key);

  @override
  State<WebViewCallFlutterPage> createState() => _WebViewCallFlutterPageState();
}

class _WebViewCallFlutterPageState extends State<WebViewCallFlutterPage> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  Future<void> _initializeWebView() async {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
            _injectJavaScript();
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('flutter://')) {
              _handleFlutterProtocol(request.url);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel(
        'flutterMethodChannel',
        onMessageReceived: (JavaScriptMessage message) {
          debugPrint('收到无返回值消息: ${message.message}');
          _handleMessage(message.message, false);
        },
      )
      ..addJavaScriptChannel(
        'flutterMethodChannelWithReturn',
        onMessageReceived: (JavaScriptMessage message) {
          debugPrint('收到带返回值消息: ${message.message}');
          _handleMessage(message.message, true);
        },
      );

    await _loadDebugHtml();
  }

  Future<void> _loadDebugHtml() async {
    try {
      String htmlContent = await rootBundle
          .loadString('assets/html/webview_call_flutter_debug.html');
      await _controller.loadHtmlString(htmlContent, baseUrl: 'assets://');
      debugPrint('WebView调用Flutter调试HTML加载成功');
    } catch (e) {
      debugPrint('加载调试HTML失败: $e');
    }
  }

  Future<void> _injectJavaScript() async {
    await _controller.runJavaScript('''
      console.log('WebView调用Flutter调试工具已初始化');
      
      // 检查JavaScriptChannel
      setTimeout(function() {
        if (window.log) {
          window.log('Flutter注入检测完成');
          window.log('flutterMethodChannel: ' + (typeof flutterMethodChannel !== 'undefined'));
          window.log('flutterMethodChannelWithReturn: ' + (typeof flutterMethodChannelWithReturn !== 'undefined'));
        }
      }, 500);
    ''');
  }

  void _handleFlutterProtocol(String url) {
    Uri uri = Uri.parse(url);
    String? dataParam = uri.queryParameters['data'];

    if (dataParam != null) {
      try {
        Map<String, dynamic> data = json.decode(Uri.decodeComponent(dataParam));
        bool withReturn = uri.host == 'methodWithReturn';
        debugPrint('处理自定义协议: ${uri.host}, 数据: $data');
        _handleMessage(json.encode(data), withReturn);
      } catch (e) {
        debugPrint('解析自定义协议数据失败: $e');
      }
    }
  }

  Future<void> _handleMessage(String message, bool withReturn) async {
    try {
      Map<String, dynamic> data = json.decode(message);
      String method = data['method'] ?? '';
      Map<String, dynamic> params = data['params'] ?? {};
      String? callbackId = data['callbackId'];

      debugPrint(
          '处理消息: method=$method, withReturn=$withReturn, callbackId=$callbackId');

      dynamic result = {};

      switch (method) {
        case 'showToast':
          result = await _handleShowToast(params);
          break;
        case 'getUserInfo':
          result = await _handleGetUserInfo(params);
          break;
        case 'getDeviceInfo':
          result = await _handleGetDeviceInfo();
          break;
        default:
          result = {'error': '未知方法: $method'};
      }

      debugPrint('方法执行结果: $result');

      // 如果需要返回值，调用JavaScript回调
      if (withReturn && callbackId != null) {
        await _controller.runJavaScript('''
          console.log('调用回调函数: $callbackId');
          if (window['$callbackId']) {
            window['$callbackId'](${json.encode(result)});
            console.log('回调函数调用成功');
          } else {
            console.error('回调函数不存在: $callbackId');
          }
        ''');
      }
    } catch (e) {
      debugPrint('处理消息失败: $e');
    }
  }

  Future<Map<String, dynamic>> _handleShowToast(
      Map<String, dynamic> params) async {
    String message = params['message'] ?? 'Hello from Flutter!';

    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );

    return {'success': true, 'message': 'Toast已显示'};
  }

  Future<Map<String, dynamic>> _handleGetUserInfo(
      Map<String, dynamic> params) async {
    int userId = params['userId'] ?? 0;

    // 模拟网络请求延迟
    await Future.delayed(const Duration(milliseconds: 800));

    return {
      'userId': userId,
      'username': 'debug_user',
      'email': 'debug@flutter.dev',
      'avatar':
          'https://flutter.dev/assets/images/shared/brand/flutter/logo/flutter-lockup.png',
      'lastLoginTime': DateTime.now().toIso8601String(),
    };
  }

  Future<Map<String, dynamic>> _handleGetDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    Map<String, dynamic> info = {};

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      info = {
        'platform': 'Android',
        'version': androidInfo.version.release,
        'model': androidInfo.model,
        'brand': androidInfo.brand,
        'sdkInt': androidInfo.version.sdkInt,
      };
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      info = {
        'platform': 'iOS',
        'version': iosInfo.systemVersion,
        'model': iosInfo.model,
        'name': iosInfo.name,
        'systemName': iosInfo.systemName,
      };
    } else {
      info = {
        'platform': Platform.operatingSystem,
        'version': Platform.operatingSystemVersion,
        'model': 'Unknown',
      };
    }

    return info;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebView → Flutter 调试工具'),
        backgroundColor: Colors.red[100],
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _controller.reload();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}

// 调试启动文件
void main() {
  runApp(const WebViewCallFlutterDebugApp());
}

class WebViewCallFlutterDebugApp extends StatelessWidget {
  const WebViewCallFlutterDebugApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebView 调用 Flutter 调试工具',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const WebViewCallFlutterPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
