import 'package:flukit_plus/flukit.dart';
import 'package:flutter/material.dart';

/**
 * Created by p_dmweidu on 2023/3/8
 * Desc: 测试 KeepAliveWrapper 控件。
 */
class KeepAliveTest extends StatelessWidget {
  const KeepAliveTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('测试 KeepAliveWrapper 控件'),
      ),
      body: ListView.builder(itemBuilder: (_, index) {
        return KeepAliveWrapper(
            keepAlive: false,
            child: ListItem(
              index: index,
            ));
      }),
    );
  }
}

class ListItem extends StatefulWidget {
  const ListItem({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text('${widget.index}'));
  }

  @override
  void dispose() {
    print('dispose ${widget.index}');
    super.dispose();
  }
}
