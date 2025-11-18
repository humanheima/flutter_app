import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'demo_tile.dart';

class AlignedDemoPage extends StatelessWidget {
  const AlignedDemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aligned - example')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AlignedGridView.count(
          crossAxisCount: 4,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          itemBuilder: (context, index) =>
              DemoTile(index: index, extent: (index % 7 + 1) * 30.0),
          itemCount: 12,
        ),
      ),
    );
  }
}
