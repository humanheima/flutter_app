import 'package:flutter/material.dart';

///
/// Created by dumingwei on 2019-10-08.
/// Desc:GridView
///
class GridViewTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text(
        "6.4 GridView",
      )),
      backgroundColor: Colors.white,
      body: Container(
          child: Column(
        children: <Widget>[
          Expanded(
            //child: buildGridViewMaxExtent(),
            child: InfiniteGridView(),
            //child: buildStaggeredGridView(),
          )
        ],
      )
          //child: buildGridView(),
          //child: countGridView(),
          //child: buildGridViewMaxExtent(),
          //child: extentGridView(),
          ),
    );
  }

  StaggeredGridView buildStaggeredGridView() {
    return new StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: 8,
      itemBuilder: (BuildContext context, int index) => new Container(
          color: Colors.green,
          child: new Center(
            child: new CircleAvatar(
              backgroundColor: Colors.white,
              child: new Text('$index'),
            ),
          )),
      staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(2, index.isEven ? 2 : 1),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }

  GridView buildGridView() {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        mainAxisSpacing: 16,
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

  GridView countGridView() {
    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 1.0,
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
  ///maxCrossAxisExtent为子元素在横轴上的最大长度
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

  GridView extentGridView() {
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

///GridView.builder
///上面我们介绍的GridView都需要一个Widget数组作为其子元素，这些方式都会提前将所有子widget都构建好，
/// 所以只适用于子Widget数量比较少时，当子widget比较多时，我们可以通过GridView.builder来动态创建子Widget。
class InfiniteGridView extends StatefulWidget {
  @override
  _InfiniteGridViewState createState() => _InfiniteGridViewState();
}

class _InfiniteGridViewState extends State<InfiniteGridView> {
  List<IconData> _icons = [];

  @override
  void initState() {
    //初始化数据
    super.initState();
    _retriveIcons();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 1.0),
      itemBuilder: (BuildContext context, int index) {
        if (index == _icons.length - 1 && _icons.length < 200) {
          //如果显示到最后一个并且Icon总数小于200时继续获取数据
          _retriveIcons();
        }

        return Icon(_icons[index]);
      },
      itemCount: _icons.length,
    );
  }

  void _retriveIcons() {
    Future.delayed(Duration(milliseconds: 200)).then((e) {
      setState(() {
        _icons.addAll([
          Icons.ac_unit,
          Icons.airport_shuttle,
          Icons.all_inclusive,
          Icons.beach_access,
          Icons.cake,
          Icons.free_breakfast
        ]);
      });
    });
  }
}
