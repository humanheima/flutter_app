import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';

///
/// Created by 杜明伟 on 2023/3/8.
/// 测试 SliverPersistentHeader

class PersistentHeaderRoute extends StatelessWidget {
  const PersistentHeaderRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('测试 SliverPersistentHeader'),
      ),
      body: CustomScrollView(
        slivers: [
          buildSliverList(),
          SliverPersistentHeader(
              pinned: true,
              delegate: SliverHeaderDelegate(
                  maxHeight: 80, minHeight: 50, child: buildHeader(1))),
          buildSliverList(),
          SliverPersistentHeader(
              pinned: true,
              delegate: SliverHeaderDelegate.fixedHeight(
                height: 50,
                child: buildHeader(2),
              )),
          buildSliverList(20),
        ],
      ),
    );
  }

  Widget buildSliverList([int count = 5]) {
    return SliverFixedExtentList(
      delegate: SliverChildBuilderDelegate((_, index) {
        return ListTile(
          title: Text('$index'),
        );
      }, childCount: count),
      itemExtent: 50,
    );
  }

  Widget buildHeader(int i) {
    return Container(
      color: Colors.lightBlue.shade200,
      alignment: Alignment.centerLeft,
      child: Text('PersistentHeader $i'),
    );
  }
}

typedef SliverHeaderBuilder = Widget Function(
    BuildContext context, double shrinkOffset, bool overlapsContent);

class SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double maxHeight;
  final double minHeight;
  SliverHeaderBuilder builder;

  SliverHeaderDelegate(
      {@required this.maxHeight, this.minHeight = 0.0, @required Widget child})
      : builder = ((a, b, c) => child),
        assert(minHeight <= maxHeight && minHeight >= 0);

  SliverHeaderDelegate.fixedHeight({
    @required double height,
    @required Widget child,
  })  : builder = ((a, b, c) => child),
        maxHeight = height,
        minHeight = height;

  SliverHeaderDelegate.builder(
      {@required this.maxHeight, this.minHeight, @required this.builder});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    Widget child = builder(context, shrinkOffset, overlapsContent);

    assert(() {
      if (child.key != null) {
        print('${child.key}: shrink：$shrinkOffset，overlaps：$overlapsContent');
      }
      return true;
    }());
    return SizedBox.expand(
      child: child,
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate.maxExtent != maxExtent ||
        oldDelegate.minExtent != minExtent;
  }
}
