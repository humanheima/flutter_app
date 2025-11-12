import 'package:flutter/material.dart';
import 'dart:math' as math;

///
/// Created by dumingwei on 2025/11/12
/// Desc: 路径动画和自定义动画示例
///
class CustomPathAnimationExample extends StatefulWidget {
  @override
  _CustomPathAnimationExampleState createState() =>
      _CustomPathAnimationExampleState();
}

class _CustomPathAnimationExampleState extends State<CustomPathAnimationExample>
    with TickerProviderStateMixin {
  late AnimationController _pathController;
  late Animation<double> _pathAnimation;

  @override
  void initState() {
    super.initState();

    _pathController = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,
    );

    _pathAnimation = CurvedAnimation(
      parent: _pathController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pathController.dispose();
    super.dispose();
  }

  // 计算圆形路径上的位置
  Offset _calculateCircularPosition(double progress) {
    final double angle = progress * 2 * 3.14159; // 2π
    final double radius = 80;
    final double centerX = 150;
    final double centerY = 150;

    return Offset(
      centerX + radius * math.cos(angle),
      centerY + radius * math.sin(angle),
    );
  }

  // 计算心形路径上的位置
  Offset _calculateHeartPosition(double progress) {
    final double t = progress * 2 * 3.14159;
    final double scale = 5;
    final double centerX = 150;
    final double centerY = 200;

    final double x = 16 * math.pow(math.sin(t), 3).toDouble();
    final double y = 13 * math.cos(t) -
        5 * math.cos(2 * t) -
        2 * math.cos(3 * t) -
        math.cos(4 * t);

    return Offset(
      centerX + x * scale,
      centerY - y * scale, // 负号是为了正确显示心形
    );
  }

  // 计算8字形路径上的位置
  Offset _calculateFigureEightPosition(double progress) {
    final double t = progress * 2 * 3.14159;
    final double scale = 60;
    final double centerX = 150;
    final double centerY = 400;

    final double x = math.sin(t);
    final double y = math.sin(2 * t);

    return Offset(
      centerX + x * scale,
      centerY + y * scale,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('路径动画示例'),
      ),
      body: Stack(
        children: [
          // 圆形路径动画
          AnimatedBuilder(
            animation: _pathAnimation,
            builder: (context, child) {
              final position = _calculateCircularPosition(_pathAnimation.value);
              return Positioned(
                left: position.dx - 15,
                top: position.dy - 15,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),

          // 心形路径动画
          AnimatedBuilder(
            animation: _pathAnimation,
            builder: (context, child) {
              final position = _calculateHeartPosition(_pathAnimation.value);
              return Positioned(
                left: position.dx - 10,
                top: position.dy - 10,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),

          // 8字形路径动画
          AnimatedBuilder(
            animation: _pathAnimation,
            builder: (context, child) {
              final position =
                  _calculateFigureEightPosition(_pathAnimation.value);
              return Positioned(
                left: position.dx - 12,
                top: position.dy - 12,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              );
            },
          ),

          // 路径轨迹显示
          CustomPaint(
            painter: PathPainter(),
            size: Size.infinite,
          ),

          // 标签
          Positioned(
            left: 20,
            top: 100,
            child: Text('圆形路径', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Positioned(
            left: 20,
            top: 160,
            child: Text('心形路径', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Positioned(
            left: 20,
            top: 350,
            child: Text('8字形路径', style: TextStyle(fontWeight: FontWeight.bold)),
          ),

          // 控制按钮
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _pathController.forward();
                  },
                  child: Text('开始'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _pathController.repeat();
                  },
                  child: Text('循环'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _pathController.reset();
                  },
                  child: Text('重置'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _pathController.stop();
                  },
                  child: Text('停止'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 自定义画笔绘制路径轨迹
class PathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // 绘制圆形轨迹
    canvas.drawCircle(Offset(150, 150), 80, paint);

    // 绘制心形轨迹
    final heartPath = Path();
    for (int i = 0; i <= 100; i++) {
      final double progress = i / 100;
      final double t = progress * 2 * 3.14159;
      final double scale = 5;
      final double centerX = 150;
      final double centerY = 200;

      final double x = 16 * math.pow(math.sin(t), 3).toDouble();
      final double y = 13 * math.cos(t) -
          5 * math.cos(2 * t) -
          2 * math.cos(3 * t) -
          math.cos(4 * t);

      final Offset point = Offset(
        centerX + x * scale,
        centerY - y * scale,
      );

      if (i == 0) {
        heartPath.moveTo(point.dx, point.dy);
      } else {
        heartPath.lineTo(point.dx, point.dy);
      }
    }
    canvas.drawPath(heartPath, paint);

    // 绘制8字形轨迹
    final figureEightPath = Path();
    for (int i = 0; i <= 100; i++) {
      final double progress = i / 100;
      final double t = progress * 2 * 3.14159;
      final double scale = 60;
      final double centerX = 150;
      final double centerY = 400;

      final double x = math.sin(t);
      final double y = math.sin(2 * t);

      final Offset point = Offset(
        centerX + x * scale,
        centerY + y * scale,
      );

      if (i == 0) {
        figureEightPath.moveTo(point.dx, point.dy);
      } else {
        figureEightPath.lineTo(point.dx, point.dy);
      }
    }
    canvas.drawPath(figureEightPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
