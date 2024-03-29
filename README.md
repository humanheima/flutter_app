# flutter_app

## 这个分支用来学习《Flutter实战》一书的例子
A new Flutter application.



## Flutter简介

### 跨平台自绘引擎

Flutter既不使用WebView，也不使用操作系统的原生控件。 相反，Flutter使用自己的高性能渲染引擎来绘制widget。这样不仅可以保证在Android和iOS上UI的一致性，而且也可以避免对原生控件依赖而带来的限制及高昂的维护成本。

Flutter使用Skia作为其2D渲染引擎，Skia是Google的一个2D图形处理函数库，包含字型、坐标转换，以及点阵图都有高效能且简洁的表现，Skia是跨平台的，并提供了非常友好的API，目前Google Chrome浏览器和Android均采用Skia作为其绘图引擎。

### 高性能

Flutter高性能主要靠两点来保证，首先，Flutter APP采用Dart语言开发。Dart在 JIT（即时编译）模式下，速度与 JavaScript基本持平。但是 Dart支持 AOT，当以 AOT模式运行时，JavaScript便远远追不上了。速度的提升对高帧率下的视图数据计算很有帮助。其次，Flutter使用自己的渲染引擎来绘制UI，布局数据等由Dart语言直接控制，所以在布局过程中不需要像RN那样要在JavaScript和Native之间通信，这在一些滑动和拖动的场景下具有明显优势，因为在滑动和拖动过程往往都会引起布局发生变化，所以JavaScript需要和Native之间不停的同步布局信息，这和在浏览器中要JavaScript频繁操作DOM所带来的问题是相同的，都会带来比较可观的性能开销。



## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.io/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.io/docs/cookbook)

For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.

### 使用自定义字体图标
以微信图标为例，从[ iconfont.cn](https://www.iconfont.cn/search) 选择一个微信图标
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


#知识点

### Flutter的空特性 待研究
