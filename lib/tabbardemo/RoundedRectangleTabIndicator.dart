import 'package:flutter/material.dart';

class RoundedRectangleTabIndicator extends Decoration {
  final Color color;
  final double height; // 高度
  final double radius; // 圆角
  final EdgeInsets padding; // 左右内边距
  final double bottomMargin; // 距离底部的间距（即距离文字的距离）

  const RoundedRectangleTabIndicator({
    required this.color,
    this.height = 3.0,
    this.radius = 6.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 12),
    this.bottomMargin = 8.0,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _RoundedRectanglePainter(
        color, height, radius, padding, bottomMargin);
  }
}

class _RoundedRectanglePainter extends BoxPainter {
  final Color color;
  final double weight;
  final double radius;
  final EdgeInsets padding;
  final double bottomMargin;

  _RoundedRectanglePainter(
      this.color, this.weight, this.radius, this.padding, this.bottomMargin);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Size size = configuration.size!;
    final Paint paint = Paint()..color = color;

    final Rect rect = Rect.fromLTWH(
      offset.dx + padding.left,
      offset.dy + size.height - weight - bottomMargin, // 关键：控制垂直位置
      size.width - padding.left - padding.right,
      weight,
    );

    final RRect rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    canvas.drawRRect(rrect, paint);
  }
}
