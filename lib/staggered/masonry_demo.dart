import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'demo_tile.dart';

///
/// Created by p_dmweidu on 2025/11/18
/// Desc:每个item只占一列，高度不固定的瀑布流示例,
///
///
class MasonryDemoPage extends StatelessWidget {
  const MasonryDemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Masonry - example')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MasonryGridView.count(
          crossAxisCount: 4,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          itemBuilder: (context, index) => DemoTile(
            index: index,
            extent: (index % 5 + 1) * 40.0,
          ),
          itemCount: 12,
        ),
      ),
    );
  }
}
