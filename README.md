# flutter_app

A new Flutter application.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.io/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.io/docs/cookbook)

For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.

### 使用自定义字体图标
以微信图标为例，从https://www.iconfont.cn/search/index?searchType=icon&q=%E5%BE%AE%E4%BF%A1选择一个微信图标，
然后添加到购物车，然后点击下载代码，然后解压下载好的压缩包，我们把解压后的文件夹命名为font_wexin，
把其中的iconfont.ttf文件拷贝到项目根目录下的fonts文件夹下

然后在pubspec.yaml中指定
```
flutter:

  fonts:
  - family: myIcon
    fonts:
    - asset: fonts/iconfont.ttf


```
然后在代码中使用
```
class MyIcons {
  // 微信图标
  static const IconData wechat =
      //图标对应对的16进制的整数，
      const IconData(0xe620, fontFamily: 'myIcon', matchTextDirection: true);
}
```
获取这个整数，可以用浏览器打开font_wexin目录下的demo_index.xml中看到
