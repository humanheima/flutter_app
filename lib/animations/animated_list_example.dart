import 'package:flutter/material.dart';

///
/// Created by dumingwei on 2025/11/12
/// Desc: 动画列表示例
///
class AnimatedListExample extends StatefulWidget {
  @override
  _AnimatedListExampleState createState() => _AnimatedListExampleState();
}

class _AnimatedListExampleState extends State<AnimatedListExample> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<String> _items = ['项目 1', '项目 2', '项目 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动画列表示例'),
      ),
      body: Column(
        children: [
          // 控制按钮
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _addItem,
                  child: Text('添加项目'),
                ),
                ElevatedButton(
                  onPressed: _items.isNotEmpty ? _removeItem : null,
                  child: Text('删除项目'),
                ),
              ],
            ),
          ),

          // AnimatedList
          Expanded(
            child: AnimatedList(
              key: _listKey,
              initialItemCount: _items.length,
              itemBuilder: (context, index, animation) {
                return _buildItem(_items[index], animation);
              },
            ),
          ),
        ],
      ),
    );
  }

  // 构建列表项
  Widget _buildItem(String item, Animation<double> animation) {
    return SlideTransition(
      position: animation.drive(
        Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: ListTile(
          title: Text(item),
          leading: CircleAvatar(
            child: Text('${_items.indexOf(item) + 1}'),
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _removeSpecificItem(item),
          ),
        ),
      ),
    );
  }

  // 添加项目
  void _addItem() {
    final newItem = '项目 ${_items.length + 1}';
    _items.add(newItem);
    _listKey.currentState?.insertItem(_items.length - 1);
  }

  // 删除最后一个项目
  void _removeItem() {
    if (_items.isNotEmpty) {
      final removedItem = _items.removeLast();
      _listKey.currentState?.removeItem(
        _items.length,
        (context, animation) => _buildRemovedItem(removedItem, animation),
      );
    }
  }

  // 删除指定项目
  void _removeSpecificItem(String item) {
    final index = _items.indexOf(item);
    if (index != -1) {
      _items.removeAt(index);
      _listKey.currentState?.removeItem(
        index,
        (context, animation) => _buildRemovedItem(item, animation),
      );
    }
  }

  // 构建被删除的项目（删除动画）
  Widget _buildRemovedItem(String item, Animation<double> animation) {
    return SlideTransition(
      position: animation.drive(
        Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(-1.0, 0.0),
        ),
      ),
      child: FadeTransition(
        opacity: animation,
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          color: Colors.red[100],
          child: ListTile(
            title: Text(
              item,
              style: TextStyle(color: Colors.red[800]),
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.delete, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
