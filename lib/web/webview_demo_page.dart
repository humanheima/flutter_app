import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WebViewDemoPage extends StatefulWidget {
  const WebViewDemoPage({Key? key}) : super(key: key);

  @override
  State<WebViewDemoPage> createState() => _WebViewDemoPageState();
}

class _WebViewDemoPageState extends State<WebViewDemoPage> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  Future<void> _initializeWebView() async {
    // 创建WebView控制器
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
            // 处理自定义协议的导航请求
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
          _handleWebViewMessage(message.message, false);
        },
      )
      ..addJavaScriptChannel(
        'flutterMethodChannelWithReturn',
        onMessageReceived: (JavaScriptMessage message) {
          _handleWebViewMessageWithReturn(message.message);
        },
      );

    // 加载双向通信演示HTML文件
    await _loadHtmlFromAssets();
  }

  Future<void> _loadHtmlFromAssets() async {
    try {
      String htmlContent =
          await rootBundle.loadString('assets/html/webview_demo.html');

      // 移除HTML中的JS引用，我们将通过runJavaScript直接注入
      htmlContent = htmlContent.replaceAll(
          '<script src="webview_bridge.js"></script>',
          '<!-- JavaScript将通过Flutter直接注入 -->');

      await _controller.loadHtmlString(htmlContent, baseUrl: 'assets://');
      debugPrint('双向通信演示HTML加载成功');
    } catch (e) {
      debugPrint('加载双向通信演示HTML失败: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('加载双向通信演示HTML失败: $e')),
      );
    }
  }

  // 注入JavaScript代码
  Future<void> _injectJavaScript() async {
    try {
      // 第一步：加载并注入JavaScript桥接文件
      String jsContent =
          await rootBundle.loadString('assets/html/webview_bridge.js');
      await _controller.runJavaScript(jsContent);
      debugPrint('✅ JavaScript桥接文件注入成功');

      // 第二步：运行初始化代码
      await _controller.runJavaScript('''
        console.log('🔄 Flutter双向通信演示WebView已初始化完成');
        
        // 检查JavaScriptChannel可用性
        if (typeof flutterMethodChannelWithReturn === 'undefined') {
          console.log('⚠️ JavaScriptChannel未就绪，将在1秒后重试');
          setTimeout(function() {
            if (window.bridge) {
              window.bridge.log('JavaScriptChannel重新检测: ' + (typeof flutterMethodChannelWithReturn !== 'undefined'));
            }
          }, 1000);
        } else {
          console.log('✅ JavaScriptChannel已就绪');
        }
        
        if (window.bridge) {
          window.bridge.log('🚀 Flutter双向通信桥接已就绪');
          window.bridge.log('JavaScriptChannel状态检测完成');
        }
      ''');
    } catch (e) {
      debugPrint('❌ JavaScript注入失败: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('JavaScript注入失败: $e')),
      );
    }
  }

  // 处理自定义协议
  void _handleFlutterProtocol(String url) {
    Uri uri = Uri.parse(url);
    String? dataParam = uri.queryParameters['data'];

    if (dataParam != null) {
      try {
        Map<String, dynamic> data = json.decode(Uri.decodeComponent(dataParam));
        bool withReturn = uri.host == 'methodWithReturn';
        _handleWebViewMessage(json.encode(data), withReturn);
      } catch (e) {
        debugPrint('解析协议数据失败: $e');
      }
    }
  }

  // 处理来自WebView的消息（无返回值）
  Future<void> _handleWebViewMessage(String message, bool withReturn) async {
    try {
      Map<String, dynamic> data = json.decode(message);
      String method = data['method'] ?? '';
      Map<String, dynamic> params = data['params'] ?? {};

      debugPrint('收到WebView调用: $method, 参数: $params');

      dynamic result;

      switch (method) {
        case 'showMessage':
          result = await _handleShowMessage(params);
          break;
        case 'showToast':
          result = await _handleShowToast(params);
          break;
        case 'customMessage':
          result = await _handleCustomMessage(params);
          break;
        default:
          result = {'error': '未知方法: $method'};
      }

      // 如果需要返回值，调用回调（用于自定义协议方案）
      if (withReturn) {
        String? callbackId = data['callbackId'];
        if (callbackId != null) {
          await _controller.runJavaScript('''
            if (window['$callbackId']) {
              window['$callbackId'](${json.encode(result)});
            }
          ''');
        }
      }
    } catch (e) {
      debugPrint('处理WebView消息失败: $e');
    }
  }

  // 处理来自WebView的消息（带返回值）- 用于JavaScriptChannel
  Future<void> _handleWebViewMessageWithReturn(String message) async {
    try {
      Map<String, dynamic> data = json.decode(message);
      String method = data['method'] ?? '';
      Map<String, dynamic> params = data['params'] ?? {};
      String? callbackId = data['callbackId'];

      debugPrint('收到WebView调用(带返回值): $method, 参数: $params, 回调ID: $callbackId');

      dynamic result;

      switch (method) {
        case 'getUserInfo':
          result = await _handleGetUserInfo(params);
          break;
        case 'getDeviceInfo':
          result = await _handleGetDeviceInfo();
          break;
        case 'showMessage':
          result = await _handleShowMessage(params);
          break;
        case 'showToast':
          result = await _handleShowToast(params);
          break;
        case 'customMessage':
          result = await _handleCustomMessage(params);
          break;
        default:
          result = {'error': '未知方法: $method'};
      }

      // 调用JavaScript回调函数返回结果
      if (callbackId != null) {
        await _controller.runJavaScript('''
          if (window['$callbackId']) {
            window['$callbackId'](${json.encode(result)});
          } else {
            console.error('回调函数 $callbackId 不存在');
          }
        ''');
      }
    } catch (e) {
      debugPrint('处理WebView带返回值消息失败: $e');
    }
  }

  // 显示消息
  Future<Map<String, dynamic>> _handleShowMessage(
      Map<String, dynamic> params) async {
    String title = params['title'] ?? '消息';
    String message = params['message'] ?? '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('确定'),
            ),
          ],
        );
      },
    );

    return {'success': true, 'message': '对话框已显示'};
  }

  // 获取用户信息
  Future<Map<String, dynamic>> _handleGetUserInfo(
      Map<String, dynamic> params) async {
    int userId = params['userId'] ?? 0;

    // 模拟异步获取用户信息
    await Future.delayed(const Duration(milliseconds: 500));

    return {
      'userId': userId,
      'username': 'flutter_user',
      'email': 'user@flutter.dev',
      'avatar':
          'https://flutter.dev/assets/images/shared/brand/flutter/logo/flutter-lockup.png',
      'lastLoginTime': DateTime.now().toIso8601String(),
    };
  }

  // 获取设备信息
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

  // 显示Toast
  Future<Map<String, dynamic>> _handleShowToast(
      Map<String, dynamic> params) async {
    String message = params['message'] ?? 'Hello from Flutter!';
    int duration = params['duration'] ?? 2000;

    Fluttertoast.showToast(
      msg: message,
      toastLength: duration > 2000 ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: duration ~/ 1000,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    return {'success': true, 'message': 'Toast已显示'};
  }

  // 处理自定义消息
  Future<Map<String, dynamic>> _handleCustomMessage(
      Map<String, dynamic> params) async {
    String message = params['message'] ?? '';
    String sender = params['sender'] ?? 'WebView';
    String? status = params['status'];

    // 添加到消息历史
    setState(() {
      _messageHistory.add('WebView→Flutter: $message');

      // 如果是状态消息，更新WebView状态
      if (status != null) {
        _messageHistory.add('WebView状态: $status');
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('收到来自 $sender 的消息: $message'),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.blue[600],
      ),
    );

    return {
      'success': true,
      'receivedMessage': message,
      'timestamp': DateTime.now().toIso8601String(),
      'flutterCounter': _counter,
      'flutterTheme': _currentTheme,
    };
  }

  // Flutter调用WebView的方法
  Future<void> _callWebViewMethod(String method,
      [Map<String, dynamic>? params]) async {
    try {
      String jsCode;
      if (method == 'showNotification' && params != null) {
        // 特殊处理showNotification方法，因为它接受两个参数
        jsCode = '''
          if (window.showNotification) {
            window.showNotification('${params['title']}', '${params['message']}');
          } else {
            console.error('WebView方法 showNotification 不存在');
          }
        ''';
      } else {
        jsCode = '''
          if (window.$method) {
            window.$method(${params != null ? json.encode(params) : ''});
          } else {
            console.error('WebView方法 $method 不存在');
          }
        ''';
      }

      await _controller.runJavaScript(jsCode);
    } catch (e) {
      debugPrint('调用WebView方法失败: $e');
    }
  }

  // 新增方法：模拟数据交换
  int _counter = 0;
  String _currentTheme = 'light';
  List<String> _messageHistory = [];

  Future<void> _sendCounterUpdate() async {
    _counter++;
    await _callWebViewMethod('updateCounter', {'value': _counter});
    setState(() {});
  }

  Future<void> _changeWebViewTheme() async {
    _currentTheme = _currentTheme == 'light' ? 'dark' : 'light';
    await _callWebViewMethod('changeTheme', {'theme': _currentTheme});
    setState(() {});
  }

  Future<void> _sendFlutterMessage() async {
    String message = 'Flutter消息 ${DateTime.now().millisecondsSinceEpoch}';
    await _callWebViewMethod('showFlutterMessage', {'message': message});
    _messageHistory.add('Flutter→WebView: $message');
    setState(() {});
  }

  Future<void> _requestWebViewStatus() async {
    await _controller.runJavaScript('''
      if (window.bridge && window.bridge.sendStatusToFlutter) {
        window.bridge.sendStatusToFlutter();
      }
    ''');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🔄 双向通信演示'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _controller.reload();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 双向通信状态栏
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[400]!, Colors.purple[400]!],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.swap_horiz, color: Colors.white),
                const SizedBox(width: 8),
                const Text(
                  '双向通信状态',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                Text(
                  'Counter: $_counter',
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(width: 12),
                Text(
                  'Theme: $_currentTheme',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          // Flutter → WebView 控制面板
          Container(
            padding: const EdgeInsets.all(12.0),
            color: Colors.green[50],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.call_made, color: Colors.green[700], size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Flutter → WebView 控制',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _sendCounterUpdate,
                      icon: const Icon(Icons.add, size: 16),
                      label: const Text('计数器+1'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _changeWebViewTheme,
                      icon: const Icon(Icons.palette, size: 16),
                      label: const Text('切换主题'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _sendFlutterMessage,
                      icon: const Icon(Icons.message, size: 16),
                      label: const Text('发送消息'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        _callWebViewMethod('showNotification', {
                          'title': 'Flutter通知',
                          'message': '来自Flutter的实时通知 ${DateTime.now().second}秒'
                        });
                      },
                      icon: const Icon(Icons.notifications, size: 16),
                      label: const Text('发送通知'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _requestWebViewStatus,
                      icon: const Icon(Icons.sync, size: 16),
                      label: const Text('请求状态'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // 消息历史
          if (_messageHistory.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              color: Colors.grey[100],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.history, size: 16),
                      const SizedBox(width: 4),
                      const Text(
                        '通信记录',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _messageHistory.clear();
                          });
                        },
                        child: const Text('清空', style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                  Container(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      reverse: true,
                      itemCount: _messageHistory.length,
                      itemBuilder: (context, index) {
                        final message =
                            _messageHistory[_messageHistory.length - 1 - index];
                        final isFromFlutter =
                            message.contains('Flutter→WebView');
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 1),
                          child: Text(
                            message,
                            style: TextStyle(
                              fontSize: 11,
                              color: isFromFlutter
                                  ? Colors.green[700]
                                  : Colors.blue[700],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          // WebView
          Expanded(
            child: Stack(
              children: [
                WebViewWidget(controller: _controller),
                if (_isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
