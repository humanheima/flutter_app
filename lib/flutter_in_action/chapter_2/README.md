# Widget 简介

## 2.2.3 Flutter中的四棵树

既然 Widget 只是描述一个UI元素的配置信息，那么真正的布局、绘制是由谁来完成的呢？Flutter 框架的的处理流程是这样的：

根据 Widget 树生成一个 Element 树，Element 树中的节点都继承自 Element 类。
根据 Element 树生成 Render 树（渲染树），渲染树中的节点都继承自RenderObject 类。
根据渲染树生成 Layer 树，然后上屏显示，Layer 树中的节点都继承自 Layer 类。
真正的布局和渲染逻辑在 Render 树中，Element 是 Widget 和 RenderObject 的粘合剂，可以理解为一个中间代理。


## State生命周期

* 例子在 lib/flutter_in_action/chapter_2/StateLifecycleTest.dart 文件中

![State生命周期](State生命周期.jpg)

* [Dart相关代码模版](https://gist.github.com/buntagonalprism/499850a3723dbded9146270c63375088)

2.2.7 在 widget 树中获取State对象

1. 通过Context 获取
2. 在 Flutter 开发中便有了一个默认的约定：如果 StatefulWidget 的状态是希望暴露出的，应当在 StatefulWidget 中提供一个of 静态方法来获取其 State 对象，开发者便可直接通过该方法来获取；如果 State不希望暴露，则不提供of方法。这个约定在 Flutter SDK 里随处可见。
3. 通过GlobalKey。

## 2.3 状态管理
