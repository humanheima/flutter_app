import 'package:flutter/material.dart';

///
/// Crete by dumingwei on 2019/3/27
/// Desc: 交错动画
/// 有一个柱状图，需要在高度增长的同时改变颜色，等到增长到最大高度后，我们需要在X轴上平移一段距离。
///
class StaggerAnimation extends StatelessWidget {
  final Animation<double> controller;
  Animation<double> height;
  Animation<EdgeInsets> padding;
  Animation<Color> color;

  StaggerAnimation({Key key, this.controller}) : super(key: key) {
    height = Tween<double>(
      begin: 0.0,
      end: 300.0,
      //间隔，前60%的动画时间
    ).animate(CurvedAnimation(parent: controller, curve: Interval(0.0, 0.6)));

    color = ColorTween(begin: Colors.green, end: Colors.red)
        //间隔，前60%的动画时间
        .animate(CurvedAnimation(
            parent: controller, curve: Interval(0.0, 0.6, curve: Curves.ease)));

    padding = Tween<EdgeInsets>(
            begin: EdgeInsets.only(left: 0), end: EdgeInsets.only(left: 100))
        //间隔，后40%的动画时间
        .animate(CurvedAnimation(
            parent: controller, curve: Interval(0.6, 1.0, curve: Curves.ease)));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: padding.value,
      child: Container(
        color: color.value,
        width: 50.0,
        height: height.value,
      ),
    );
  }
}
