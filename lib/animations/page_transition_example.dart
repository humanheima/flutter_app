import 'package:flutter/material.dart';

///
/// Created by dumingwei on 2025/11/12
/// Desc: 页面过渡动画示例
///
class PageTransitionExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('页面过渡动画'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 滑动过渡
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(_createSlideRoute());
              },
              child: Text('滑动过渡'),
            ),
            SizedBox(height: 20),

            // 淡入过渡
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(_createFadeRoute());
              },
              child: Text('淡入过渡'),
            ),
            SizedBox(height: 20),

            // 缩放过渡
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(_createScaleRoute());
              },
              child: Text('缩放过渡'),
            ),
            SizedBox(height: 20),

            // 旋转过渡
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(_createRotationRoute());
              },
              child: Text('旋转过渡'),
            ),
            SizedBox(height: 20),

            // 自定义组合过渡
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(_createCustomRoute());
              },
              child: Text('自定义组合过渡'),
            ),
          ],
        ),
      ),
    );
  }

  // 滑动过渡
  Route _createSlideRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          SecondPage(title: '滑动过渡页面'),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  // 淡入过渡
  Route _createFadeRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          SecondPage(title: '淡入过渡页面'),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  // 缩放过渡
  Route _createScaleRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          SecondPage(title: '缩放过渡页面'),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.elasticOut,
          )),
          child: child,
        );
      },
    );
  }

  // 旋转过渡
  Route _createRotationRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          SecondPage(title: '旋转过渡页面'),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return RotationTransition(
          turns: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          )),
          child: child,
        );
      },
    );
  }

  // 自定义组合过渡
  Route _createCustomRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          SecondPage(title: '自定义组合过渡'),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // 组合多种动画效果
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.bounceOut,
          )),
          child: FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(
                begin: 0.8,
                end: 1.0,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              )),
              child: child,
            ),
          ),
        );
      },
    );
  }
}

// 第二个页面
class SecondPage extends StatelessWidget {
  final String title;

  const SecondPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '这是$title',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('返回'),
            ),
          ],
        ),
      ),
    );
  }
}
