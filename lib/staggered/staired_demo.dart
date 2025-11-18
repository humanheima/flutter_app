import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'demo_tile.dart';

class StairedDemoPage extends StatelessWidget {
  const StairedDemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: const Text('Staired - example')),
      body: GridView.custom(

        gridDelegate: SliverStairedGridDelegate(
          crossAxisSpacing: 8,
          //crossAxisSpacing: 0,
          mainAxisSpacing: 4,
          //mainAxisSpacing: 0,
          startCrossAxisDirectionReversed: false,
          pattern: const [
            StairedGridTile(0.5, 1),//宽度是整个宽度的一半，宽高比是1:1
            StairedGridTile(0.5, 3 / 4), //宽度是整个宽度的一半，宽高比是4:3
            StairedGridTile(1.0, 10 / 4), //宽度是整个宽度，宽高比是4:10
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
