import 'package:flutter/material.dart';

///
/// Created by dumingwei on 2025/11/12
/// Desc: 位置移动动画示例
///
class PositionAnimationExample extends StatefulWidget {
  @override
  _PositionAnimationExampleState createState() =>
      _PositionAnimationExampleState();
}

class _PositionAnimationExampleState extends State<PositionAnimationExample>
    with TickerProviderStateMixin {
  late AnimationController _moveController;
  late Animation<Offset> _slideAnimation;
  late Animation<RelativeRect> _positionAnimation;

  // 用于AnimatedPositioned的位置值
  double _left = 50;
  double _top = 50;

  @override
  void initState() {
    super.initState();

    _moveController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    // 滑动动画
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(1.5, 0),
    ).animate(CurvedAnimation(
      parent: _moveController,
      curve: Curves.elasticOut,
    ));

    // 位置动画（用于PositionedTransition）
    _positionAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(50, 50, 0, 0),
      end: RelativeRect.fromLTRB(200, 200, 0, 0),
    ).animate(CurvedAnimation(
      parent: _moveController,
      curve: Curves.bounceOut,
    ));
  }

  @override
  void dispose() {
    _moveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('位置移动动画'),
      ),
      body: Stack(
        children: [
          // SlideTransition 示例
          Positioned(
            top: 100,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('SlideTransition:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SlideTransition(
                  position: _slideAnimation,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Icon(Icons.circle, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

          // PositionedTransition 示例
          PositionedTransition(
            rect: _positionAnimation,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.star, color: Colors.white, size: 30),
            ),
          ),

          // AnimatedPositioned 示例
          AnimatedPositioned(
            left: _left,
            top: _top + 300,
            duration: Duration(milliseconds: 800),
            curve: Curves.easeInOut,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _left = _left == 50 ? 250 : 50;
                  _top = _top == 50 ? 100 : 50;
                });
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.touch_app, color: Colors.white),
              ),
            ),
          ),

          // 说明文本
          Positioned(
            left: 20,
            top: 280,
            child: Text(
              'AnimatedPositioned (点击移动):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
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
                    _moveController.forward();
                  },
                  child: Text('开始移动'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _moveController.reverse();
                  },
                  child: Text('返回'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _moveController.repeat(reverse: true);
                  },
                  child: Text('来回移动'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _moveController.stop();
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
