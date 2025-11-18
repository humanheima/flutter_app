import 'package:flutter/material.dart';

/// 一个简单的示例 Tile，用在多个 demo 中
class DemoTile extends StatelessWidget {
  final int index;
  final double? extent;

  const DemoTile({Key? key, required this.index, this.extent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Colors.primaries[index % Colors.primaries.length].shade400;
    final height = extent ?? 100.0 + (index % 5) * 20.0;

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          'Tile $index',
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
