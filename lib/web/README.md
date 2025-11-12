# Flutter WebView 交互演示

这个演示项目展示了Flutter应用与WebView中JavaScript代码之间的双向通信功能。

## 功能特性

### 🚀 Flutter调用WebView
- 更新WebView UI内容
- 向WebView发送通知消息
- 获取WebView中的数据

### 📱 WebView调用Flutter
- **无返回值调用**：显示消息对话框、Toast提示
- **有返回值调用**：获取用户信息、设备信息
- **自定义消息**：发送任意消息给Flutter

## 项目结构

```
lib/web/
├── web_demos.dart                        # 统一导出文件
├── web_demo_entry_page.dart              # 演示入口页面
├── webview_call_flutter_page.dart        # WebView调用Flutter演示页面
├── flutter_call_webview_page.dart        # Flutter调用WebView演示页面
└── webview_test_main.dart                # 测试启动文件

assets/html/
├── webview_demo.html                     # 双向通信演示HTML页面
├── webview_call_flutter_debug.html       # WebView→Flutter调试页面
├── flutter_call_webview.html             # Flutter→WebView演示页面
└── webview_bridge.js                     # JavaScript桥接文件
```

## 依赖包

```yaml
dependencies:
  webview_flutter: ^4.4.2      # WebView组件
  device_info_plus: ^9.1.1     # 设备信息获取
  fluttertoast: ^8.2.8          # Toast显示
```

## 快速开始

### 1. 安装依赖
```bash
flutter pub get
```

### 2. 运行演示
```bash
# 方式1：运行完整应用然后导航到Web演示
flutter run

# 方式2：直接运行WebView测试
flutter run lib/web/webview_test_main.dart
```

### 3. 功能测试

#### Flutter → WebView
在Flutter页面顶部的控制面板中：
- 点击"更新WebView"按钮 → WebView页面显示Flutter发送的消息
- 点击"发送通知"按钮 → WebView页面显示通知内容
- 点击"获取WebView数据"按钮 → 获取WebView的当前状态信息

#### WebView → Flutter
在WebView页面中：
- 点击"调用Flutter(无返回值)" → 显示Flutter对话框
- 点击"调用Flutter(有返回值)" → 获取并显示用户信息
- 点击"获取设备信息" → 显示设备详细信息
- 点击"显示Toast" → 显示Flutter Toast消息
- 输入自定义消息并发送 → Flutter显示SnackBar

## 技术实现

### JavaScript调用Flutter

```javascript
// 1. 无返回值调用
bridge.callFlutterMethod('showMessage', {
  title: 'Hello',
  message: 'Message from WebView'
});

// 2. 有返回值调用
const result = await bridge.callFlutterMethodWithReturn('getUserInfo', {
  userId: 12345
});
```

### Flutter调用JavaScript

```dart
// 1. 调用无参数方法
await _controller.runJavaScript('window.updateWebView()');

// 2. 调用带参数方法
await _controller.runJavaScript('''
  window.showNotification('Title', 'Message');
''');

// 3. 获取返回值
Object result = await _controller.runJavaScriptReturningResult('''
  window.getWebViewData();
''');
```

### 消息通道设置

```dart
// 添加JavaScript通道
_controller.addJavaScriptChannel(
  'flutterMethodChannel',
  onMessageReceived: (JavaScriptMessage message) {
    // 处理WebView发来的消息
  },
);
```

## 支持的方法

### Flutter端支持的方法
| 方法名 | 参数 | 返回值 | 描述 |
|--------|------|--------|------|
| showMessage | title, message | success状态 | 显示对话框 |
| getUserInfo | userId | 用户信息对象 | 获取用户信息 |
| getDeviceInfo | 无 | 设备信息对象 | 获取设备信息 |
| showToast | message, duration | success状态 | 显示Toast |
| customMessage | message, sender | 接收状态 | 自定义消息处理 |

### WebView端支持的方法
| 方法名 | 参数 | 描述 |
|--------|------|------|
| updateWebView | data对象 | 更新页面内容 |
| showNotification | title, message | 显示通知 |
| getWebViewData | 无 | 返回页面数据 |

## 注意事项

1. **网络权限**：确保在Android manifest中添加了网络权限（如果需要加载远程内容）
2. **iOS配置**：在iOS中可能需要额外的Info.plist配置
3. **调试**：使用Chrome DevTools调试WebView中的JavaScript代码
4. **错误处理**：所有的异步调用都包含了错误处理机制

## 故障排除

### 常见问题

1. **WebView无法加载**
   - 检查assets/html/文件是否正确添加到pubspec.yaml
   - 确认HTML文件路径正确

2. **JavaScript调用失败**
   - 检查JavaScript代码语法
   - 确认方法名称匹配
   - 查看控制台错误信息

3. **Flutter方法未响应**
   - 检查JavaScriptChannel是否正确添加
   - 确认JSON格式正确
   - 查看Flutter debug输出

## 扩展开发

要添加新的交互功能：

1. 在`webview_bridge.js`中添加新的JavaScript方法
2. 在`webview_demo_page.dart`中的`_handleWebViewMessage`方法中添加处理逻辑
3. 在HTML页面中添加对应的UI控件
4. 测试双向通信功能

## 许可证

MIT License