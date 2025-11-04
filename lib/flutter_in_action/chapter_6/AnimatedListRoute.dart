import 'package:flutter/material.dart';

///
/// Created by 杜明伟 on 2023/2/27.
///

class AnimatedListRoute extends StatefulWidget {
  const AnimatedListRoute({Key? key}) : super(key: key);

  @override
  _AnimatedListRouteState createState() => new _AnimatedListRouteState();
}

class _AnimatedListRouteState extends State<AnimatedListRoute> {
  var data = <String>[];
  int count = 5;

  final globalKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    for (var i = 0; i < count; i++) {
      data.add('${i + 1}');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedList'),
      ),
      body: Material(
        child: Stack(
          children: [
            AnimatedList(
                initialItemCount: data.length,
                key: globalKey,
                itemBuilder: (BuildContext context, int index,
                    Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: buildItem(context, index),
                  );
                }),
            buildAddButton(),
          ],
        ),
      ),
    );
  }

  // 构建列表项
  Widget buildItem(BuildContext context, int index) {
    String char = data[index];
    return ListTile(
      //数字不会重复，所以作为Key
      key: ValueKey(char),
      title: Text('$char'),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        //点击时删除
        onPressed: () => onDelete(context, index),
      ),
    );
  }

  void onDelete(BuildContext context, int index) {
    // 使用 AnimatedList 自带的删除动画
    final removed = data[index];
    setState(() {
      globalKey.currentState?.removeItem(
        index,
        (context, animation) {
          // 使用被删除的数据构建固定的 Item，避免索引变化导致显示错误
          final item = ListTile(
            key: ValueKey(removed),
            title: Text(removed),
            trailing: const Icon(Icons.delete),
          );
          // 从数据源中移除
          data.removeAt(index);
          print('删除 $removed');
          return FadeTransition(
            opacity: CurvedAnimation(
                parent: animation,
                //让透明度变化的更快一些
                curve: const Interval(0.5, 1.0)),
            // 不断缩小列表项的高度
            child: SizeTransition(
              sizeFactor: animation,
              axisAlignment: 0.0,
              child: item,
            ),
          );
        },
        // 动画时间为 200 ms
        duration: const Duration(milliseconds: 200),
      );
    });
  }

  Widget buildAddButton() {
    return Positioned(
      child: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          data.add('${++count}');
          globalKey.currentState?.insertItem(data.length - 1);
          print("添加 $count");
        },
      ),
      bottom: 30,
      left: 0,
      right: 0,
    );
  }
}
