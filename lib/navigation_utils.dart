import 'package:flutter/material.dart';

/// 导航工具类
/// 提供无白色闪烁的页面转场效果
class NavigationUtils {
  /// 使用淡入淡出效果推送新页面（无白色闪烁）
  ///
  /// 参数:
  /// - [context]: 当前的 BuildContext
  /// - [page]: 要导航到的页面
  /// - [duration]: 转场动画时长，默认 250 毫秒
  ///
  /// 返回:
  /// - Future<T?> 页面返回的结果
  static Future<T?> pushFade<T>(
    BuildContext context,
    Widget page, {
    Duration duration = const Duration(milliseconds: 250),
  }) {
    return Navigator.of(context).push<T>(
      PageRouteBuilder<T>(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: duration,
        opaque: true,
      ),
    );
  }

  /// 使用从右到左滑动效果推送新页面（无白色闪烁）
  ///
  /// 参数:
  /// - [context]: 当前的 BuildContext
  /// - [page]: 要导航到的页面
  /// - [duration]: 转场动画时长，默认 300 毫秒
  ///
  /// 返回:
  /// - Future<T?> 页面返回的结果
  static Future<T?> pushSlide<T>(
    BuildContext context,
    Widget page, {
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return Navigator.of(context).push<T>(
      PageRouteBuilder<T>(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // 从右侧开始
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          final tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: duration,
        opaque: true,
      ),
    );
  }

  /// 使用缩放效果推送新页面（无白色闪烁）
  ///
  /// 参数:
  /// - [context]: 当前的 BuildContext
  /// - [page]: 要导航到的页面
  /// - [duration]: 转场动画时长，默认 250 毫秒
  ///
  /// 返回:
  /// - Future<T?> 页面返回的结果
  static Future<T?> pushScale<T>(
    BuildContext context,
    Widget page, {
    Duration duration = const Duration(milliseconds: 250),
  }) {
    return Navigator.of(context).push<T>(
      PageRouteBuilder<T>(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return ScaleTransition(
            scale: Tween<double>(begin: 0.8, end: 1.0).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              ),
            ),
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
        transitionDuration: duration,
        opaque: true,
      ),
    );
  }

  /// 替换当前页面（无白色闪烁）
  ///
  /// 参数:
  /// - [context]: 当前的 BuildContext
  /// - [page]: 要导航到的页面
  /// - [duration]: 转场动画时长，默认 250 毫秒
  ///
  /// 返回:
  /// - Future<T?> 页面返回的结果
  static Future<T?> pushReplacementFade<T, TO>(
    BuildContext context,
    Widget page, {
    Duration duration = const Duration(milliseconds: 250),
    TO? result,
  }) {
    return Navigator.of(context).pushReplacement<T, TO>(
      PageRouteBuilder<T>(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: duration,
        opaque: true,
      ),
      result: result,
    );
  }

  /// 推送新页面并移除所有之前的页面（无白色闪烁）
  /// 常用于登录成功后跳转到首页
  ///
  /// 参数:
  /// - [context]: 当前的 BuildContext
  /// - [page]: 要导航到的页面
  /// - [duration]: 转场动画时长，默认 250 毫秒
  ///
  /// 返回:
  /// - Future<T?> 页面返回的结果
  static Future<T?> pushAndRemoveUntilFade<T>(
    BuildContext context,
    Widget page, {
    Duration duration = const Duration(milliseconds: 250),
  }) {
    return Navigator.of(context).pushAndRemoveUntil<T>(
      PageRouteBuilder<T>(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: duration,
        opaque: true,
      ),
      (route) => false, // 移除所有之前的路由
    );
  }
}
