import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WebViewRealPageDemo extends StatefulWidget {
  const WebViewRealPageDemo({Key? key}) : super(key: key);

  @override
  State<WebViewRealPageDemo> createState() => _WebViewRealPageDemoState();
}

class _WebViewRealPageDemoState extends State<WebViewRealPageDemo> {
  late final WebViewController _controller;
  bool _isLoading = true;
  double _progress = 0.0;
  String _currentUrl = '';
  String _pageTitle = '';
  bool _canGoBack = false;
  bool _canGoForward = false;
  String? _errorMessage;

  // 默认URL
  final String _defaultUrl = 'http://test-h5.rolepub.com/feeds/detail?id=42';
  final TextEditingController _urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _urlController.text = _defaultUrl;
    _initializeWebView();
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  Future<void> _initializeWebView() async {
    // 创建WebView控制器
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent(
          'Mozilla/5.0 (Linux; Android 10; Pixel 6 Pro) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.120 Mobile Safari/537.36 dreamer')
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
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
              _currentUrl = url;
              _errorMessage = null;
              _progress = 0.0;
            });
            debugPrint('🌐 页面开始加载: $url');
          },
          onProgress: (int progress) {
            setState(() {
              _progress = progress / 100;
            });
          },
          onPageFinished: (String url) async {
            setState(() {
              _isLoading = false;
              _currentUrl = url;
            });

            // 获取页面标题
            final title = await _controller.getTitle();
            setState(() {
              _pageTitle = title ?? '未知页面';
            });

            // 更新导航状态
            _updateNavigationState();

            // 注入JavaScript桥接代码实现双向交互
            await _injectJavaScriptBridge();

            debugPrint('✅ 页面加载完成: $url');
            debugPrint('📄 页面标题: $_pageTitle');
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              _isLoading = false;
              _errorMessage = error.description;
            });
            debugPrint('❌ 页面加载错误: ${error.description}');

            Fluttertoast.showToast(
              msg: '加载错误: ${error.description}',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
            );
          },
          onNavigationRequest: (NavigationRequest request) {
            debugPrint('🔗 导航请求: ${request.url}');

            // 可以在这里添加URL过滤逻辑
            // 例如：阻止某些域名的访问

            return NavigationDecision.navigate;
          },
        ),
      );

    // 加载默认URL
    await _loadUrl(_defaultUrl);
  }

  Future<void> _loadUrl(String url) async {
    try {
      // 确保URL有协议前缀
      if (!url.startsWith('http://') && !url.startsWith('https://')) {
        url = 'https://$url';
      }

      setState(() {
        _errorMessage = null;
      });

      await _controller.loadRequest(Uri.parse(url));
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
      debugPrint('❌ URL加载失败: $e');
    }
  }

  Future<void> _updateNavigationState() async {
    try {
      final canGoBack = await _controller.canGoBack();
      final canGoForward = await _controller.canGoForward();

      setState(() {
        _canGoBack = canGoBack;
        _canGoForward = canGoForward;
      });
    } catch (e) {
      debugPrint('❌ 更新导航状态失败: $e');
    }
  }

  // JavaScript注入和双向交互相关方法
  bool _isBridgeInjected = false;
  String _lastWebViewMessage = '';
  String _lastFlutterMessage = '';

  Future<void> _injectJavaScriptBridge() async {
    try {
      // 第一步：加载并注入JavaScript桥接文件
      String jsContent =
          await rootBundle.loadString('assets/html/webview_bridge.js');
      await _controller.runJavaScript(jsContent);
      debugPrint('✅ JavaScript桥接文件注入成功');

      // 第二步：注入针对真实网页的增强功能
      await _controller.runJavaScript('''
        console.log('🔄 Flutter与真实网页双向通信已初始化');
        
        // 创建Flutter通信按钮
        if (!document.getElementById('flutter-bridge-panel')) {
          const panel = document.createElement('div');
          panel.id = 'flutter-bridge-panel';
          panel.style.cssText = `
            position: fixed;
            top: 10px;
            right: 10px;
            background: rgba(0, 0, 0, 0.8);
            color: white;
            padding: 10px;
            border-radius: 8px;
            z-index: 9999;
            font-size: 12px;
            min-width: 200px;
          `;
          
          panel.innerHTML = `
            <div style="margin-bottom: 8px; font-weight: bold;">Flutter Bridge</div>
            <button onclick="testFlutterCall()" style="margin: 2px; padding: 4px 8px; font-size: 11px;">
              📱 调用Flutter
            </button>
            <button onclick="requestUserInfo()" style="margin: 2px; padding: 4px 8px; font-size: 11px;">
              👤 获取用户信息
            </button>
            <button onclick="showFlutterToast()" style="margin: 2px; padding: 4px 8px; font-size: 11px;">
              💬 显示Toast
            </button>
            <div id="bridge-status" style="margin-top: 8px; font-size: 10px; color: #ccc;">
              状态: 已连接
            </div>
          `;
          
          document.body.appendChild(panel);
        }
        
        // 定义测试函数
        window.testFlutterCall = function() {
          if (window.bridge) {
            window.bridge.callFlutter('showMessage', {
              title: '来自网页的消息',
              message: '这是从真实网页发送的消息：' + new Date().toLocaleTimeString()
            });
          }
        };
        
        window.requestUserInfo = function() {
          if (window.bridge) {
            window.bridge.callFlutterWithReturn('getUserInfo', {userId: 123}, function(result) {
              document.getElementById('bridge-status').innerHTML = 
                '用户: ' + (result.username || '未知');
            });
          }
        };
        
        window.showFlutterToast = function() {
          if (window.bridge) {
            window.bridge.callFlutter('showToast', {
              message: '来自网页的Toast消息！',
              duration: 3000
            });
          }
        };
        
        // Flutter调用网页的方法
        window.showFlutterMessage = function(data) {
          const status = document.getElementById('bridge-status');
          if (status) {
            status.innerHTML = 'Flutter消息: ' + (data.message || '无内容');
            status.style.color = '#4CAF50';
            setTimeout(() => {
              status.style.color = '#ccc';
              status.innerHTML = '状态: 已连接';
            }, 3000);
          }
        };
        
        window.updateWebPageTheme = function(data) {
          const theme = data.theme || 'light';
          if (theme === 'dark') {
            document.body.style.filter = 'invert(1) hue-rotate(180deg)';
          } else {
            document.body.style.filter = 'none';
          }
          console.log('网页主题已切换为:', theme);
        };
        
        if (window.bridge) {
          window.bridge.log('🚀 真实网页双向通信桥接已就绪');
        }
      ''');

      // 第三步：显示注入成功的提示
      Fluttertoast.showToast(
        msg: '✅ JavaScript桥接已注入，可进行双向交互',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

      setState(() {
        _isBridgeInjected = true;
      });
    } catch (e) {
      debugPrint('❌ JavaScript桥接注入失败: $e');
      Fluttertoast.showToast(
        msg: '❌ JavaScript注入失败: $e',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  // 处理来自WebView的消息（无返回值）
  Future<void> _handleWebViewMessage(String message, bool withReturn) async {
    try {
      Map<String, dynamic> data = json.decode(message);
      String method = data['method'] ?? '';
      Map<String, dynamic> params = data['params'] ?? {};

      debugPrint('🌐 收到网页调用: $method, 参数: $params');

      switch (method) {
        case 'showMessage':
          await _handleShowMessage(params);
          break;
        case 'showToast':
          await _handleShowToast(params);
          break;
        case 'customMessage':
          await _handleCustomMessage(params);
          break;
        default:
          debugPrint('未知方法: $method');
      }

      setState(() {
        _lastWebViewMessage = '网页→Flutter: $method';
      });
    } catch (e) {
      debugPrint('❌ 处理网页消息失败: $e');
    }
  }

  // 处理来自WebView的消息（带返回值）
  Future<void> _handleWebViewMessageWithReturn(String message) async {
    try {
      Map<String, dynamic> data = json.decode(message);
      String method = data['method'] ?? '';
      Map<String, dynamic> params = data['params'] ?? {};
      String? callbackId = data['callbackId'];

      debugPrint('🌐 收到网页调用(带返回值): $method, 参数: $params');

      dynamic result;

      switch (method) {
        case 'getUserInfo':
          result = await _handleGetUserInfo(params);
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
          }
        ''');
      }

      setState(() {
        _lastWebViewMessage = '网页→Flutter: $method (返回值)';
      });
    } catch (e) {
      debugPrint('❌ 处理网页带返回值消息失败: $e');
    }
  }

  // 处理显示消息
  Future<Map<String, dynamic>> _handleShowMessage(
      Map<String, dynamic> params) async {
    String title = params['title'] ?? '来自网页的消息';
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
      'username': 'real_webpage_user',
      'email': 'user@realwebpage.com',
      'avatar':
          'https://flutter.dev/assets/images/shared/brand/flutter/logo/flutter-lockup.png',
      'lastLoginTime': DateTime.now().toIso8601String(),
    };
  }

  // 显示Toast
  Future<Map<String, dynamic>> _handleShowToast(
      Map<String, dynamic> params) async {
    String message = params['message'] ?? 'Hello from Real WebPage!';
    int duration = params['duration'] ?? 2000;

    Fluttertoast.showToast(
      msg: message,
      toastLength: duration > 2000 ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
    );

    return {'success': true, 'message': 'Toast已显示'};
  }

  // 处理自定义消息
  Future<Map<String, dynamic>> _handleCustomMessage(
      Map<String, dynamic> params) async {
    String message = params['message'] ?? '';

    setState(() {
      _lastWebViewMessage = '网页消息: $message';
    });

    return {
      'success': true,
      'receivedMessage': message,
      'timestamp': DateTime.now().toIso8601String(),
    };
  }

  // Flutter调用网页的方法
  Future<void> _callWebPageMethod(String method,
      [Map<String, dynamic>? params]) async {
    try {
      String jsCode = '''
        if (window.$method) {
          window.$method(${params != null ? json.encode(params) : ''});
        } else {
          console.error('网页方法 $method 不存在');
        }
      ''';

      await _controller.runJavaScript(jsCode);
      setState(() {
        _lastFlutterMessage = 'Flutter→网页: $method';
      });
    } catch (e) {
      debugPrint('❌ 调用网页方法失败: $e');
    }
  }

  void _showUrlInputDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('输入网址'),
          content: TextField(
            controller: _urlController,
            decoration: const InputDecoration(
              hintText: '请输入完整的网址',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.url,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _loadUrl(_urlController.text.trim());
              },
              child: const Text('访问'),
            ),
          ],
        );
      },
    );
  }

  void _showQuickLinks() {
    final quickLinks = [
      {'name': '测试页面', 'url': 'http://test-h5.rolepub.com/feeds/detail?id=42'},
      {'name': 'Flutter官网', 'url': 'https://flutter.dev'},
      {'name': '百度', 'url': 'https://www.baidu.com'},
      {'name': 'GitHub', 'url': 'https://github.com'},
      {'name': '掘金', 'url': 'https://juejin.cn'},
    ];

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '快速访问',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ...quickLinks
                  .map((link) => ListTile(
                        leading: const Icon(Icons.link),
                        title: Text(link['name']!),
                        subtitle: Text(
                          link['url']!,
                          style: const TextStyle(fontSize: 12),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          _urlController.text = link['url']!;
                          _loadUrl(link['url']!);
                        },
                      ))
                  .toList(),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '🌐 真实网页加载',
              style: TextStyle(fontSize: 16),
            ),
            if (_pageTitle.isNotEmpty)
              Text(
                _pageTitle,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.link_outlined),
            onPressed: _showUrlInputDialog,
            tooltip: '输入网址',
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_outline),
            onPressed: _showQuickLinks,
            tooltip: '快速访问',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _controller.reload();
            },
            tooltip: '刷新页面',
          ),
        ],
      ),
      body: Column(
        children: [
          // 网址栏
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border(
                bottom: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: Row(
              children: [
                // 导航按钮
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: _canGoBack ? Colors.blue : Colors.grey,
                  ),
                  onPressed: _canGoBack
                      ? () async {
                          await _controller.goBack();
                          _updateNavigationState();
                        }
                      : null,
                  tooltip: '后退',
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward,
                    color: _canGoForward ? Colors.blue : Colors.grey,
                  ),
                  onPressed: _canGoForward
                      ? () async {
                          await _controller.goForward();
                          _updateNavigationState();
                        }
                      : null,
                  tooltip: '前进',
                ),
                const SizedBox(width: 8),
                // URL显示
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Text(
                      _currentUrl.isNotEmpty ? _currentUrl : '准备加载...',
                      style: const TextStyle(fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // 安全指示器
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _currentUrl.startsWith('https://')
                        ? Colors.green[100]
                        : Colors.orange[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _currentUrl.startsWith('https://')
                            ? Icons.lock
                            : Icons.lock_open,
                        size: 12,
                        color: _currentUrl.startsWith('https://')
                            ? Colors.green[700]
                            : Colors.orange[700],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _currentUrl.startsWith('https://') ? 'HTTPS' : 'HTTP',
                        style: TextStyle(
                          fontSize: 10,
                          color: _currentUrl.startsWith('https://')
                              ? Colors.green[700]
                              : Colors.orange[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // 进度条
          if (_isLoading)
            LinearProgressIndicator(
              value: _progress,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          // 双向交互控制面板
          if (_isBridgeInjected && _errorMessage == null)
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple[50]!, Colors.blue[50]!],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                border: Border(
                  bottom: BorderSide(color: Colors.grey[300]!),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.swap_horiz,
                          color: Colors.purple[700], size: 18),
                      const SizedBox(width: 8),
                      Text(
                        'Flutter ↔ 网页双向交互',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.purple[700],
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.check_circle,
                                size: 12, color: Colors.green[700]),
                            const SizedBox(width: 4),
                            Text(
                              '已注入',
                              style: TextStyle(
                                  fontSize: 10, color: Colors.green[700]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Flutter → 网页',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.blue[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Wrap(
                              spacing: 6,
                              runSpacing: 4,
                              children: [
                                _buildControlButton(
                                  '发送消息',
                                  Icons.message,
                                  Colors.blue,
                                  () => _callWebPageMethod(
                                      'showFlutterMessage', {
                                    'message':
                                        'Flutter消息 ${DateTime.now().second}秒'
                                  }),
                                ),
                                _buildControlButton(
                                  '切换主题',
                                  Icons.palette,
                                  Colors.blue,
                                  () => _callWebPageMethod(
                                      'updateWebPageTheme', {
                                    'theme': DateTime.now().second % 2 == 0
                                        ? 'dark'
                                        : 'light'
                                  }),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '通信记录',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              height: 36,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (_lastFlutterMessage.isNotEmpty)
                                      Text(
                                        _lastFlutterMessage,
                                        style: TextStyle(
                                            fontSize: 9,
                                            color: Colors.blue[600]),
                                      ),
                                    if (_lastWebViewMessage.isNotEmpty)
                                      Text(
                                        _lastWebViewMessage,
                                        style: TextStyle(
                                            fontSize: 9,
                                            color: Colors.green[600]),
                                      ),
                                    if (_lastFlutterMessage.isEmpty &&
                                        _lastWebViewMessage.isEmpty)
                                      Text(
                                        '暂无通信记录',
                                        style: TextStyle(
                                            fontSize: 9,
                                            color: Colors.grey[500]),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '💡 网页右上角已注入交互按钮，可测试网页→Flutter通信',
                    style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          // 错误提示
          if (_errorMessage != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.red[50],
              child: Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.red[700]),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '页面加载失败',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red[700],
                          ),
                        ),
                        Text(
                          _errorMessage!,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.red[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _controller.reload();
                    },
                    child: const Text('重试'),
                  ),
                ],
              ),
            ),
          // WebView
          Expanded(
            child: _errorMessage == null
                ? WebViewWidget(controller: _controller)
                : Container(
                    color: Colors.grey[100],
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            '页面加载失败',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
          // 底部状态栏
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              border: Border(
                top: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  _isLoading ? Icons.sync : Icons.check_circle,
                  size: 16,
                  color: _isLoading ? Colors.orange : Colors.green,
                ),
                const SizedBox(width: 8),
                Text(
                  _isLoading
                      ? '正在加载... ${(_progress * 100).toInt()}%'
                      : '页面加载完成',
                  style: const TextStyle(fontSize: 12),
                ),
                const Spacer(),
                if (Platform.isAndroid)
                  Text(
                    'Android WebView',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[600],
                    ),
                  ),
                if (Platform.isIOS)
                  Text(
                    'WKWebView',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[600],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      '页面操作',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      leading: const Icon(Icons.copy),
                      title: const Text('复制当前网址'),
                      onTap: () async {
                        Navigator.of(context).pop();
                        // 这里可以添加复制到剪贴板的功能
                        Fluttertoast.showToast(
                          msg: '网址已复制: $_currentUrl',
                          toastLength: Toast.LENGTH_SHORT,
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.share),
                      title: const Text('分享页面'),
                      onTap: () {
                        Navigator.of(context).pop();
                        // 这里可以添加分享功能
                        Fluttertoast.showToast(
                          msg: '分享功能待实现',
                          toastLength: Toast.LENGTH_SHORT,
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.javascript),
                      title: const Text('执行JavaScript'),
                      onTap: () {
                        Navigator.of(context).pop();
                        _showJavaScriptDialog();
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Icons.more_vert),
        tooltip: '更多操作',
      ),
    );
  }

  void _showJavaScriptDialog() {
    final TextEditingController jsController = TextEditingController();
    jsController.text = 'document.title';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('执行JavaScript'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('在当前页面执行JavaScript代码：'),
              const SizedBox(height: 8),
              TextField(
                controller: jsController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '输入JavaScript代码',
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                  await _controller.runJavaScript(jsController.text);
                  Fluttertoast.showToast(
                    msg: 'JavaScript执行成功',
                    backgroundColor: Colors.green,
                  );
                } catch (e) {
                  Fluttertoast.showToast(
                    msg: 'JavaScript执行失败: $e',
                    backgroundColor: Colors.red,
                    toastLength: Toast.LENGTH_LONG,
                  );
                }
              },
              child: const Text('执行'),
            ),
          ],
        );
      },
    );
  }

  // 构建控制按钮
  Widget _buildControlButton(
      String label, IconData icon, Color color, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 12),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        textStyle: const TextStyle(fontSize: 10),
        minimumSize: Size.zero,
      ),
    );
  }
}
