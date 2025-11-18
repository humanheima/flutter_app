# Dio 代理抓包 Demo

这个 Demo 演示了如何在 Flutter 项目中配置 Dio 使用 Android 系统代理进行网络请求抓包。

## 功能特性

- ✅ 自动检测系统代理配置
- ✅ 支持手动设置代理地址
- ✅ 处理 HTTPS 自签名证书
- ✅ 完整的请求/响应日志
- ✅ 友好的错误提示

## 使用方法

### 1. 准备抓包工具

选择以下任一工具：
- **Charles Proxy** (推荐，macOS/Windows)
- **Fiddler** (Windows)
- **mitmproxy** (跨平台，命令行)

### 2. 配置电脑端

以 Charles 为例：

1. 启动 Charles
2. 菜单栏选择 `Proxy` -> `Proxy Settings`
3. 确认端口号（默认 8888）
4. 勾选 `Enable transparent HTTP proxying`
5. 查看电脑 IP 地址：
   - macOS: 系统设置 -> 网络 -> WiFi -> 详细信息
   - Windows: CMD 运行 `ipconfig`

### 3. 配置 Android 手机

1. 确保手机和电脑连接同一 WiFi
2. 打开 WiFi 设置，长按当前连接的 WiFi
3. 选择 "修改网络" 或 "网络详情"
4. 代理设置选择 "手动"
5. 填入：
   - 主机名：电脑的 IP 地址（如 192.168.1.100）
   - 端口：8888（或你的抓包工具端口）
6. 保存设置

### 4. HTTPS 抓包配置（可选）

如需抓取 HTTPS 请求：

#### Charles 证书安装

**电脑端：**
1. Charles 菜单：`Help` -> `SSL Proxying` -> `Install Charles Root Certificate`
2. 信任该证书

**Android 手机端：**
1. Charles 菜单：`Help` -> `SSL Proxying` -> `Install Charles Root Certificate on a Mobile Device`
2. 按照提示在手机浏览器访问 `chls.pro/ssl`
3. 下载并安装证书
4. 在 Charles 中启用 SSL 代理：
   - `Proxy` -> `SSL Proxying Settings`
   - 勾选 `Enable SSL Proxying`
   - 添加 `*:*` 或特定域名

**Android 7.0+ 额外配置：**

需要在 AndroidManifest.xml 中配置网络安全策略：

```xml
<!-- android/app/src/main/AndroidManifest.xml -->
<application
    android:networkSecurityConfig="@xml/network_security_config"
    ...>
```

创建 `android/app/src/main/res/xml/network_security_config.xml`：

```xml
<?xml version="1.0" encoding="utf-8"?>
<network-security-config>
    <base-config cleartextTrafficPermitted="true">
        <trust-anchors>
            <!-- 信任系统证书 -->
            <certificates src="system" />
            <!-- 信任用户安装的证书（用于抓包） -->
            <certificates src="user" />
        </trust-anchors>
    </base-config>
</network-security-config>
```

### 5. 运行 Demo

1. 在项目中导入：
```dart
import 'package:flutter_app/proxy/dio_proxy_demo.dart';
```

2. 在你的路由或主页面中添加：
```dart
// 例如在 main.dart 中
MaterialApp(
  home: DioProxyDemo(), // 或通过路由跳转
)
```

3. 运行应用，点击"发送测试请求"按钮

4. 在 Charles 中查看捕获的请求

## 代码说明

### 自动检测系统代理

```dart
final proxyHost = Platform.environment['HTTP_PROXY'] ??
    Platform.environment['http_proxy'];
```

### 手动设置代理

如果系统代理未配置，可以在代码中手动设置：

```dart
const manualProxy = '192.168.1.100:8888'; // 电脑 IP:端口

(_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
  final client = HttpClient();
  client.findProxy = (uri) {
    return 'PROXY $manualProxy';
  };
  // 允许自签名证书（用于 HTTPS 抓包）
  client.badCertificateCallback =
      (X509Certificate cert, String host, int port) => true;
  return client;
};
```

### 拦截器日志

Demo 中已配置拦截器，可在控制台查看详细日志：

```dart
_dio.interceptors.add(
  InterceptorsWrapper(
    onRequest: (options, handler) {
      debugPrint('===> 请求 [${options.method}] ${options.uri}');
      return handler.next(options);
    },
    onResponse: (response, handler) {
      debugPrint('<== 响应 [${response.statusCode}]');
      return handler.next(response);
    },
    onError: (error, handler) {
      debugPrint('<=== 错误: ${error.message}');
      return handler.next(error);
    },
  ),
);
```

## 常见问题

### 1. 请求超时

**原因：** 代理服务器地址或端口配置错误

**解决：**
- 检查手机 WiFi 代理设置
- 确认电脑 IP 地址是否正确
- 确认抓包工具是否正常运行

### 2. HTTPS 请求失败

**原因：** 未安装或信任证书

**解决：**
- 按照上述步骤安装证书
- Android 7.0+ 需要配置网络安全策略
- 在代码中设置 `badCertificateCallback`

### 3. 无法捕获请求

**原因：** 抓包工具未正确配置

**解决：**
- Charles: 确认启用了 `SSL Proxying`
- 检查防火墙是否阻止了连接
- 尝试在代理工具中添加手机 IP 到白名单

### 4. Android 模拟器抓包

如果使用 Android 模拟器：

- 代理地址使用：`10.0.2.2:8888`（10.0.2.2 是模拟器访问宿主机的特殊地址）

## 生产环境注意事项

⚠️ **重要：** 以下配置仅用于开发调试，不应在生产环境中使用：

1. `badCertificateCallback = true` - 允许所有证书
2. `cleartextTrafficPermitted="true"` - 允许明文流量
3. 信任用户安装的证书

生产环境应该：
- 使用条件编译区分 debug 和 release 模式
- 仅在 debug 模式启用代理配置
- 移除或限制证书信任策略

示例：

```dart
void _setupDioProxy() {
  // 仅在 debug 模式配置代理
  if (kDebugMode) {
    final proxyHost = Platform.environment['HTTP_PROXY'];
    if (proxyHost != null && proxyHost.isNotEmpty) {
      (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
        final client = HttpClient();
        client.findProxy = (uri) => 'PROXY $proxyHost';
        client.badCertificateCallback = (cert, host, port) => true;
        return client;
      };
    }
  }
}
```

## 参考资源

- [Dio 官方文档](https://pub.dev/packages/dio)
- [Charles 使用指南](https://www.charlesproxy.com/documentation/)
- [Android 网络安全配置](https://developer.android.com/training/articles/security-config)

## 许可证

MIT
