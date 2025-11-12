import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Flutter调用WebView演示页面
///
/// ## 🎯 主要用途
/// 演示 **Flutter → WebView** 的各种调用方式和功能。
///
/// ## 🔧 功能特性
/// - **消息发送**：向WebView发送文本消息
/// - **计数器控制**：更新和递增WebView中的计数器
/// - **数据传递**：发送复杂对象数据到WebView
/// - **主题控制**：动态改变WebView的主题颜色
/// - **通知显示**：在WebView中显示不同类型的通知
/// - **状态获取**：从WebView获取当前状态信息
/// - **界面清理**：清空WebView中的所有内容
///
/// ## 📱 演示内容
/// 1. 基础调用（无返回值）
/// 2. 带返回值调用
/// 3. 复杂数据传递
/// 4. UI控制和交互
/// 5. 状态同步
class FlutterCallWebViewPage extends StatefulWidget {
  const FlutterCallWebViewPage({Key? key}) : super(key: key);

  @override
  State<FlutterCallWebViewPage> createState() => _FlutterCallWebViewPageState();
}

class _FlutterCallWebViewPageState extends State<FlutterCallWebViewPage> {
  late final WebViewController _controller;
  bool _isLoading = true;
  int _counter = 0;
  String _lastResult = '暂无结果';

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
        ),
      );

    await _loadHtmlFromAssets();
  }

  Future<void> _loadHtmlFromAssets() async {
    try {
      String htmlContent =
          await rootBundle.loadString('assets/html/flutter_call_webview.html');
      await _controller.loadHtmlString(htmlContent, baseUrl: 'assets://');
      debugPrint('Flutter调用WebView演示HTML加载成功');
    } catch (e) {
      debugPrint('加载HTML文件失败: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('加载HTML文件失败: $e')),
      );
    }
  }

  Future<void> _injectJavaScript() async {
    await _controller.runJavaScript('''
      console.log('Flutter调用WebView演示页面已初始化');
    ''');
  }

  // 发送简单消息
  Future<void> _sendMessage() async {
    String message = '这是来自Flutter的消息 ${DateTime.now().millisecondsSinceEpoch}';

    try {
      Object result = await _controller.runJavaScriptReturningResult('''
        window.showMessage('$message');
      ''');

      setState(() {
        _lastResult = '消息发送成功: $result';
      });

      _showSnackBar('✅ 消息已发送到WebView');
    } catch (e) {
      setState(() {
        _lastResult = '发送失败: $e';
      });
      _showSnackBar('❌ 消息发送失败');
    }
  }

  // 更新计数器
  Future<void> _updateCounter() async {
    _counter += 10;

    try {
      Object result = await _controller.runJavaScriptReturningResult('''
        window.updateCounter($_counter);
      ''');

      setState(() {
        _lastResult = '计数器更新结果: $result';
      });

      _showSnackBar('🔢 计数器已更新为 $_counter');
    } catch (e) {
      setState(() {
        _lastResult = '更新失败: $e';
      });
    }
  }

  // 递增计数器
  Future<void> _incrementCounter() async {
    try {
      Object result = await _controller.runJavaScriptReturningResult('''
        window.incrementCounter(5);
      ''');

      setState(() {
        _counter += 5;
        _lastResult = '递增结果: $result';
      });

      _showSnackBar('➕ 计数器已递增 +5');
    } catch (e) {
      setState(() {
        _lastResult = '递增失败: $e';
      });
    }
  }

  // 发送复杂数据
  Future<void> _sendComplexData() async {
    Map<String, dynamic> data = {
      'user': {
        'name': 'Flutter用户',
        'id': 12345,
        'avatar':
            'https://flutter.dev/assets/images/shared/brand/flutter/logo/flutter-lockup.png'
      },
      'settings': {'theme': 'dark', 'language': 'zh-CN', 'notifications': true},
      'metadata': {
        'timestamp': DateTime.now().toIso8601String(),
        'platform': 'Flutter',
        'version': '3.0.0'
      }
    };

    try {
      String jsonData = json.encode(data).replaceAll('"', '\\"');
      Object result = await _controller.runJavaScriptReturningResult('''
        window.showData(JSON.parse("$jsonData"));
      ''');

      setState(() {
        _lastResult = '数据发送结果: $result';
      });

      _showSnackBar('📊 复杂数据已发送');
    } catch (e) {
      setState(() {
        _lastResult = '数据发送失败: $e';
      });
    }
  }

  // 改变WebView主题
  Future<void> _changeTheme() async {
    List<Map<String, String>> themes = [
      {'primary': '#667eea', 'secondary': '#764ba2'},
      {'primary': '#f093fb', 'secondary': '#f5576c'},
      {'primary': '#4facfe', 'secondary': '#00f2fe'},
      {'primary': '#43e97b', 'secondary': '#38f9d7'},
      {'primary': '#fa709a', 'secondary': '#fee140'},
    ];

    Map<String, String> randomTheme =
        themes[DateTime.now().millisecond % themes.length];

    try {
      String themeJson = json.encode(randomTheme).replaceAll('"', '\\"');
      Object result = await _controller.runJavaScriptReturningResult('''
        window.changeTheme(JSON.parse("$themeJson"));
      ''');

      setState(() {
        _lastResult = '主题更改结果: $result';
      });

      _showSnackBar('🎨 WebView主题已更改');
    } catch (e) {
      setState(() {
        _lastResult = '主题更改失败: $e';
      });
    }
  }

  // 显示通知
  Future<void> _showNotification(String type) async {
    Map<String, Map<String, String>> notifications = {
      'info': {'title': '信息通知', 'message': '这是一个信息类型的通知'},
      'success': {'title': '成功通知', 'message': '操作已成功完成'},
      'warning': {'title': '警告通知', 'message': '请注意这个警告信息'},
      'error': {'title': '错误通知', 'message': '发生了一个错误'},
    };

    Map<String, String> notification = notifications[type]!;

    try {
      Object result = await _controller.runJavaScriptReturningResult('''
        window.showNotification('${notification['title']}', '${notification['message']}', '$type');
      ''');

      setState(() {
        _lastResult = '通知显示结果: $result';
      });

      _showSnackBar('📢 ${notification['title']}已显示');
    } catch (e) {
      setState(() {
        _lastResult = '通知显示失败: $e';
      });
    }
  }

  // 获取WebView状态
  Future<void> _getWebViewStatus() async {
    try {
      Object result = await _controller.runJavaScriptReturningResult('''
        window.getWebViewStatus();
      ''');

      setState(() {
        _lastResult = 'WebView状态: $result';
      });

      _showSnackBar('📊 WebView状态已获取');
    } catch (e) {
      setState(() {
        _lastResult = '获取状态失败: $e';
      });
    }
  }

  // 清空WebView内容
  Future<void> _clearWebView() async {
    try {
      Object result = await _controller.runJavaScriptReturningResult('''
        window.clearAll();
      ''');

      setState(() {
        _counter = 0;
        _lastResult = '清空结果: $result';
      });

      _showSnackBar('🧹 WebView内容已清空');
    } catch (e) {
      setState(() {
        _lastResult = '清空失败: $e';
      });
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter → WebView 演示'),
        backgroundColor: Colors.green[100],
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
          // Flutter控制面板
          Container(
            padding: const EdgeInsets.all(12.0),
            color: Colors.grey[100],
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.call_made, color: Colors.green),
                    const SizedBox(width: 8),
                    const Text(
                      'Flutter 调用控制:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // 第一行按钮
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _sendMessage,
                        icon: const Icon(Icons.message, size: 16),
                        label: const Text('发送消息'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _updateCounter,
                        icon: const Icon(Icons.update, size: 16),
                        label: const Text('更新计数器'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // 第二行按钮
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _incrementCounter,
                        icon: const Icon(Icons.add, size: 16),
                        label: const Text('递增计数器'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _sendComplexData,
                        icon: const Icon(Icons.data_object, size: 16),
                        label: const Text('发送数据'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // 第三行按钮
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _changeTheme,
                        icon: const Icon(Icons.palette, size: 16),
                        label: const Text('改变主题'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _getWebViewStatus,
                        icon: const Icon(Icons.info, size: 16),
                        label: const Text('获取状态'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // 通知按钮行
                Row(
                  children: [
                    Expanded(
                      child: PopupMenuButton<String>(
                        onSelected: _showNotification,
                        itemBuilder: (BuildContext context) => [
                          const PopupMenuItem(
                              value: 'info', child: Text('📘 信息通知')),
                          const PopupMenuItem(
                              value: 'success', child: Text('✅ 成功通知')),
                          const PopupMenuItem(
                              value: 'warning', child: Text('⚠️ 警告通知')),
                          const PopupMenuItem(
                              value: 'error', child: Text('❌ 错误通知')),
                        ],
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.indigo,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.notifications,
                                  color: Colors.white, size: 16),
                              SizedBox(width: 4),
                              Text('显示通知',
                                  style: TextStyle(color: Colors.white)),
                              Icon(Icons.arrow_drop_down,
                                  color: Colors.white, size: 16),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _clearWebView,
                        icon: const Icon(Icons.clear, size: 16),
                        label: const Text('清空内容'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // 结果显示
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    border: Border.all(color: Colors.blue[200]!),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '最后调用结果:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _lastResult,
                        style: const TextStyle(fontSize: 11),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
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
