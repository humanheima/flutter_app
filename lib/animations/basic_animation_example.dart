import 'package:flutter/material.dart';

///
/// Created by dumingwei on 2025/11/12
/// Desc: 基础动画示例
///
class BasicAnimationExample extends StatefulWidget {
  @override
  _BasicAnimationExampleState createState() => _BasicAnimationExampleState();
}

class _BasicAnimationExampleState extends State<BasicAnimationExample>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 300.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('基础动画示例'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Container(
                  width: _animation.value,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              },
            ),
            SizedBox(height: 30),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _controller.forward();
                    },
                    child: Text('开始动画'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _controller.reverse();
                    },
                    child: Text('反向动画'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _controller.repeat();
                    },
                    child: Text('重复动画'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _controller.stop();
                    },
                    child: Text('停止动画'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
