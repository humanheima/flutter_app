import 'package:flutter/material.dart';
import 'staggered_demo.dart';
import 'masonry_demo.dart';
import 'quilted_demo.dart';
import 'woven_demo.dart';
import 'staired_demo.dart';
import 'aligned_demo.dart';

class StaggeredDemosIndex extends StatelessWidget {
  const StaggeredDemosIndex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final demos = <_DemoItem>[
      _DemoItem('Staggered', const StaggeredDemoPage()),
      _DemoItem('Masonry', const MasonryDemoPage()),
      _DemoItem('Quilted', const QuiltedDemoPage()),
      _DemoItem('Woven', const WovenDemoPage()),
      _DemoItem('Staired', const StairedDemoPage()),
      _DemoItem('Aligned', const AlignedDemoPage()),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('flutter_staggered_grid_view demos')),
      body: ListView.separated(
        itemCount: demos.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final d = demos[index];
          return ListTile(
            title: Text(d.title),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => d.page),
            ),
          );
        },
      ),
    );
  }
}

class _DemoItem {
  final String title;
  final Widget page;
  _DemoItem(this.title, this.page);
}
