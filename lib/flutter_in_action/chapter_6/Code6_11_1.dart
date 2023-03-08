import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';

///
/// Created by 杜明伟 on 2023/3/8.
/// 6.11.2 自定义 Sliver，这一节没看懂，后面慢慢消化

class SliverPersistentHeaderToBoxRoute extends StatelessWidget {
  const SliverPersistentHeaderToBoxRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义 Sliver'),
      ),
      body: CustomScrollView(
        slivers: [
          buildSliverList(5),
          SliverPersistentHeaderToBox.builder(builder: headerBuilder),
          buildSliverList(5),
          SliverPersistentHeaderToBox(child: wTitle('Title 2')),
          buildSliverList(50),
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

  // 当 header 固定后显示阴影
  Widget headerBuilder(context, maxExtent, fixed) {
    // 获取当前应用主题，关于主题相关内容将在后面章节介绍，现在
    // 我们要从主题中获取一些颜色。
    var theme = Theme.of(context);
    return Material(
      child: Container(
        color: fixed ? Colors.white : theme.canvasColor,
        child: wTitle('Title 1'),
      ),
      elevation: fixed ? 4 : 0,
      shadowColor: theme.appBarTheme.shadowColor,
    );
  }

  // 我们约定小写字母 w 开头的函数代表是需要构建一个 Widget，这比 buildXX 会更简洁
  Widget wTitle(String text) =>
      ListTile(title: Text(text), onTap: () => print(text));
}
