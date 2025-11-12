import 'package:flutter/material.dart';

///
/// Created by dumingwei on 2025/11/12
/// Desc: 颜色渐变动画示例
///
class ColorAnimationExample extends StatefulWidget {
  @override
  _ColorAnimationExampleState createState() => _ColorAnimationExampleState();
}

class _ColorAnimationExampleState extends State<ColorAnimationExample>
    with TickerProviderStateMixin {
  late AnimationController _colorController;
  late Animation<Color?> _colorAnimation;

  // 用于 AnimatedContainer 的颜色
  Color _containerColor = Colors.red;

  @override
  void initState() {
    super.initState();

    _colorController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    // 创建颜色渐变动画
    _colorAnimation = ColorTween(
      begin: Colors.red,
      end: Colors.blue,
    ).animate(CurvedAnimation(
      parent: _colorController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('颜色动画示例'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ColorTransition 使用 AnimatedBuilder
            Text('ColorTween + AnimatedBuilder:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            AnimatedBuilder(
              animation: _colorAnimation,
              builder: (context, child) {
                return Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: _colorAnimation.value,
                    borderRadius: BorderRadius.circular(75),
                  ),
                  child: Center(
                    child: Text(
                      'Color\nAnimation',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 40),

            // AnimatedContainer 颜色动画
            Text('AnimatedContainer 颜色:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            AnimatedContainer(
              duration: Duration(seconds: 1),
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: _containerColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Icon(
                  Icons.palette,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),

            SizedBox(height: 40),

            // 多色渐变示例
            Text('多色渐变动画:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            AnimatedBuilder(
              animation: _colorController,
              builder: (context, child) {
                return Container(
                  width: 200,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.lerp(Colors.purple, Colors.orange,
                            _colorController.value)!,
                        Color.lerp(
                            Colors.pink, Colors.cyan, _colorController.value)!,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Center(
                    child: Text(
                      '渐变动画',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 40),

            // 控制按钮
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _colorController.forward();
                  },
                  child: Text('开始颜色动画'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _colorController.reverse();
                  },
                  child: Text('反向动画'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _colorController.repeat(reverse: true);
                  },
                  child: Text('循环动画'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _containerColor = _containerColor == Colors.red
                          ? Colors.green
                          : _containerColor == Colors.green
                              ? Colors.purple
                              : Colors.red;
                    });
                  },
                  child: Text('切换容器颜色'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
