import 'package:flutter/material.dart';

///
/// Crete by dumingwei on 2019/3/24
/// Desc: CustomScrollView
/// Sliver有细片、小片之意，在Flutter中，Sliver通常指具有特定滚动效果的可滚动块。
///

class CustomScrollViewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Material(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Demo'),
              background: Image.asset(
                "images/avatar.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: new SliverGrid(
              //Grid
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //Grid按两列显示
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 4.0,
              ),
              delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  //创建子widget
                  return new Container(
                    alignment: Alignment.center,
                    color: Colors.cyan[100 * (index % 9)],
                    child: new Text('grid item $index'),
                  );
                },
                childCount: 20,
              ),
            ),
          ),
          new SliverFixedExtentList(
              delegate: new SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return new Container(
                    alignment: Alignment.center,
                    color: Colors.lightBlue[100 * (index % 9)],
                    child: new Text('list item $index'));
              }, childCount: 50),
              itemExtent: 50.0)
        ],
      ),
    );
  }

  GridView buildGridView() {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
      ),
      children: <Widget>[
        Icon(Icons.ac_unit),
        Icon(Icons.airport_shuttle),
        Icon(Icons.all_inclusive),
        Icon(Icons.beach_access),
        Icon(Icons.cake),
        Icon(Icons.free_breakfast)
      ],
    );
  }

  ///纵轴宽度固定
  ///例如网格布局是竖直方向上的，宽度为500px，如果maxCrossAxisExtent指定为150.0,
  ///那么SliverGridDelegateWithMaxCrossAxisExtent会创建4列，每一列宽125px。
  GridView buildGridViewMaxExtent() {
    return GridView(
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 120.0, childAspectRatio: 2.0 //宽高比为2
          ),
      children: <Widget>[
        Icon(Icons.ac_unit),
        Icon(Icons.airport_shuttle),
        Icon(Icons.all_inclusive),
        Icon(Icons.beach_access),
        Icon(Icons.cake),
        Icon(Icons.free_breakfast),
      ],
    );
  }
}
