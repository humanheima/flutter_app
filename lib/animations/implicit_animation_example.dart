import 'package:flutter/material.dart';

///
/// Created by dumingwei on 2025/11/12
/// Desc: 隐式动画示例 - 使用AnimatedContainer等Widget
///
class ImplicitAnimationExample extends StatefulWidget {
  @override
  _ImplicitAnimationExampleState createState() =>
      _ImplicitAnimationExampleState();
}

class _ImplicitAnimationExampleState extends State<ImplicitAnimationExample> {

  double _width = 100;
  double _height = 100;
  Color _color = Colors.red;
  BorderRadius _borderRadius = BorderRadius.circular(8);
  double _opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('隐式动画示例'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,//水平居中
          children: [
            // AnimatedContainer 示例
            AnimatedContainer(
              width: _width,
              height: _height,
              decoration: BoxDecoration(
                color: _color,
                borderRadius: _borderRadius,
              ),
              duration: Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
            ),
            SizedBox(height: 30),

            // AnimatedOpacity 示例
            AnimatedOpacity(
              opacity: _opacity,
              duration: Duration(milliseconds: 500),
              child: Container(
                width: 100,
                height: 50,
                color: Colors.green,
                child: Center(
                  child: Text(
                    '透明度动画',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),

            // 控制按钮
            Wrap(
              spacing: 10,
              runSpacing: 10,//换行时的间距
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _width = _width == 100 ? 200 : 100;
                      _height = _height == 100 ? 200 : 100;
                    });
                  },
                  child: Text('改变大小'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _color = _color == Colors.red ? Colors.blue : Colors.red;
                    });
                  },
                  child: Text('改变颜色'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _borderRadius = _borderRadius == BorderRadius.circular(8)
                          ? BorderRadius.circular(50)
                          : BorderRadius.circular(8);
                    });
                  },
                  child: Text('改变圆角'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _opacity = _opacity == 1.0 ? 0.3 : 1.0;
                    });
                  },
                  child: Text('改变透明度'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
