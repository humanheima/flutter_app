import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'demo_tile.dart';

///
/// Created by p_dmweidu on 2025/11/18
/// Desc: 宽高相等
///
class QuiltedDemoPage extends StatelessWidget {
  const QuiltedDemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quilted - example')),
      body: GridView.custom(
        gridDelegate: SliverQuiltedGridDelegate(
          crossAxisCount: 4,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          ///注意重复模式
          ///第一次循环先来一个大块的2x2，然后两个1x1，最后一个1x2；
          ///第二次循环则是先来一个1x2，然后两个1x1，最后一个2x2；
          ///第三次循环又是和第一次一样，以此类推，666
          repeatPattern: QuiltedGridRepeatPattern.inverted,//

          pattern: const [
            QuiltedGridTile(2, 2),
            QuiltedGridTile(1, 1),
            QuiltedGridTile(1, 1),
            QuiltedGridTile(1, 2),
          ],
        ),
        childrenDelegate: SliverChildBuilderDelegate(
          (context, index) => DemoTile(index: index),
          childCount: 12,
        ),
      ),
    );
  }
}
