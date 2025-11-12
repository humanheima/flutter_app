import 'package:flutter/material.dart';
import 'dart:math' as math;

///
/// Created by dumingwei on 2025/11/12
/// Desc: 旋转和缩放动画示例
///
class RotationScaleAnimationExample extends StatefulWidget {
  @override
  _RotationScaleAnimationExampleState createState() =>
      _RotationScaleAnimationExampleState();
}

class _RotationScaleAnimationExampleState
    extends State<RotationScaleAnimationExample> with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _scaleController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // 旋转动画控制器
    _rotationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.linear,
    ));

    // 缩放动画控制器
    _scaleController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.5,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('旋转和缩放动画'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 旋转动画
            AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationAnimation.value,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 50),

            // 缩放动画
            AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 50),

            // 组合动画（同时旋转和缩放）
            AnimatedBuilder(
              animation:
                  Listenable.merge([_rotationAnimation, _scaleAnimation]),
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationAnimation.value,
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        Icons.settings,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 30),

            // 控制按钮
            Wrap(
              spacing: 10,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _rotationController.forward();
                  },
                  child: Text('开始旋转'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _rotationController.repeat();
                  },
                  child: Text('持续旋转'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _scaleController.forward().then((_) {
                      _scaleController.reverse();
                    });
                  },
                  child: Text('缩放动画'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _rotationController.stop();
                    _scaleController.stop();
                  },
                  child: Text('停止所有'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
