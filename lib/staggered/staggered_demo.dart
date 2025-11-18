import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'demo_tile.dart';

///
/// Created by p_dmweidu on 2025/11/18
/// Desc: StaggeredGrid.count 示例,
///
///
class StaggeredDemoPage extends StatelessWidget {
  const StaggeredDemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Staggered - example')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        //默认是竖直方向的瀑布流，crossAxisCount表示横轴上有多少个单元格
        child: StaggeredGrid.count(
          crossAxisCount: 4,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: const [
            StaggeredGridTile.count(
              crossAxisCellCount: 2, //横轴占2个单元格
              mainAxisCellCount: 2, //主轴，在这个例子中，占2个单元格
              child: DemoTile(index: 0),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 1,
              child: DemoTile(index: 1),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: DemoTile(index: 2),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: DemoTile(index: 3),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 4,
              mainAxisCellCount: 2,
              child: DemoTile(index: 4),
            ),
          ],
        ),
      ),
    );
  }
}
