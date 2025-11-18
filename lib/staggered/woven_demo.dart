import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'demo_tile.dart';

///
/// Created by p_dmweidu on 2025/11/18
/// Desc:
///
class WovenDemoPage extends StatelessWidget {
  const WovenDemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Woven - example')),
      body: GridView.custom(
        gridDelegate: SliverWovenGridDelegate.count(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,

          ///
          /// 注意重复模式
          /// 第一次循环先来一个完整宽度的tile，宽高比1：1
          /// 然后一个宽高比为5:7的tile，且对齐方式为靠右对齐
          ///重复方式为 z 字形重复
          ///
          pattern: [
            const WovenGridTile(1),
            WovenGridTile(
              5 / 7,
              crossAxisRatio: 0.9,
              //宽度是一个column的90%，可以把 mainAxisSpacing ，crossAxisSpacing 都设置为0，方便观察效果
              alignment: AlignmentDirectional.centerEnd,
            ),
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
