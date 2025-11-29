import 'package:flutter/material.dart';

void main() => runApp(PopupMenuDemoApp());

class PopupMenuDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PopupMenu Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PopupMenuDemoPage(),
    );
  }
}

class PopupMenuDemoPage extends StatefulWidget {
  @override
  _PopupMenuDemoPageState createState() => _PopupMenuDemoPageState();
}

class _PopupMenuDemoPageState extends State<PopupMenuDemoPage> {
  String _selectedAction = '未选择任何操作';
  String _contextMenuResult = '未使用右键菜单';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PopupMenu 使用示例'),
        actions: [
          // AppBar 右侧的 PopupMenuButton
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert),
            onSelected: (String value) {
              setState(() {
                _selectedAction = '从 AppBar 选择了: $value';
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('选择了: $value')),
              );
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: '设置',
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('设置'),
                ),
              ),
              PopupMenuItem<String>(
                value: '帮助',
                child: ListTile(
                  leading: Icon(Icons.help),
                  title: Text('帮助'),
                ),
              ),
              PopupMenuDivider(), // 分割线
              PopupMenuItem<String>(
                value: '关于',
                child: ListTile(
                  leading: Icon(Icons.info),
                  title: Text('关于'),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 状态显示
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('状态信息:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text(_selectedAction),
                    Text(_contextMenuResult),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // 示例1: 基本的 PopupMenuButton
            Text('示例1: 基本 PopupMenuButton',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            PopupMenuButton<String>(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('点击显示菜单'),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
              onSelected: (String value) {
                setState(() {
                  _selectedAction = '基本菜单选择了: $value';
                });
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(value: '复制', child: Text('复制')),
                PopupMenuItem<String>(value: '粘贴', child: Text('粘贴')),
                PopupMenuItem<String>(value: '删除', child: Text('删除')),
              ],
            ),
            SizedBox(height: 20),

            // 示例2: 使用 showMenu 函数
            Text('示例2: 使用 showMenu 函数',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => _showCustomMenu(context),
                  child: Text('默认宽度菜单'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _showWideMenu(context),
                  child: Text('设置宽度菜单'),
                ),
              ],
            ),
            SizedBox(height: 20),

            // 示例3: 右键上下文菜单
            Text('示例3: 右键上下文菜单',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            GestureDetector(
              onSecondaryTapDown: (TapDownDetails details) {
                _showContextMenu(context, details.globalPosition);
              },
              child: Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    '右键点击此区域显示上下文菜单\n(移动设备长按)',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              onLongPress: () {
                // 移动设备上的长按事件
                _showContextMenuAtCenter(context);
              },
            ),
            SizedBox(height: 20),

            // 示例4: 带图标和禁用项的菜单
            Text('示例4: 复杂菜单样式',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            PopupMenuButton<String>(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('复杂菜单', style: TextStyle(color: Colors.white)),
              ),
              onSelected: (String value) {
                setState(() {
                  _selectedAction = '复杂菜单选择了: $value';
                });
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: '新建文件',
                  child: ListTile(
                    leading: Icon(Icons.add_circle, color: Colors.green),
                    title: Text('新建文件'),
                    subtitle: Text('创建新的文件'),
                  ),
                ),
                PopupMenuItem<String>(
                  value: '打开文件',
                  child: ListTile(
                    leading: Icon(Icons.folder_open, color: Colors.blue),
                    title: Text('打开文件'),
                  ),
                ),
                PopupMenuDivider(),
                PopupMenuItem<String>(
                  enabled: false, // 禁用项
                  value: '最近文件',
                  child: ListTile(
                    leading: Icon(Icons.history, color: Colors.grey),
                    title:
                        Text('最近文件 (禁用)', style: TextStyle(color: Colors.grey)),
                  ),
                ),
                PopupMenuItem<String>(
                  value: '退出',
                  child: ListTile(
                    leading: Icon(Icons.exit_to_app, color: Colors.red),
                    title: Text('退出', style: TextStyle(color: Colors.red)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 使用 showMenu 函数显示自定义菜单
  void _showCustomMenu(BuildContext context) async {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context)!.context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    final String? selected = await showMenu<String>(
      context: context,
      position: position,
      items: <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: '选项A',
          child: Row(
            children: [
              Icon(Icons.star, color: Colors.amber),
              SizedBox(width: 8),
              Text('选项A'),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: '选项B',
          child: Row(
            children: [
              Icon(Icons.favorite, color: Colors.red),
              SizedBox(width: 8),
              Text('选项B'),
            ],
          ),
        ),
        PopupMenuDivider(),
        PopupMenuItem<String>(
          value: '更多选项',
          child: Row(
            children: [
              Icon(Icons.more_horiz),
              SizedBox(width: 8),
              Text('更多选项'),
            ],
          ),
        ),
      ],
      elevation: 8.0,
    );

    if (selected != null) {
      setState(() {
        _selectedAction = 'showMenu 选择了: $selected';
      });
    }
  }

  // 显示带宽度设置的菜单
  void _showWideMenu(BuildContext context) async {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context)!.context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    final String? selected = await showMenu<String>(
      context: context,
      position: position,
      // 通过设置 constraints 来控制菜单宽度
      constraints: BoxConstraints(
        minWidth: 150, // 最小宽度
        maxWidth: 350, // 最大宽度
        minHeight: 0,
        maxHeight: double.infinity,
      ),
      items: <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: '这是一个很长的选项名称用来测试宽度设置',
          child: Container(
            width: 300, // 通过 Container 也可以控制内容宽度
            child: Row(
              children: [
                Icon(Icons.text_fields, color: Colors.blue),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '这是一个很长的选项名称用来测试宽度设置',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
        PopupMenuItem<String>(
          value: '固定宽度选项',
          child: Container(
            width: 300,
            child: Row(
              children: [
                Icon(Icons.settings, color: Colors.green),
                SizedBox(width: 8),
                Text('固定宽度选项'),
              ],
            ),
          ),
        ),
        PopupMenuDivider(),
        PopupMenuItem<String>(
          value: '带详细描述的选项',
          child: Container(
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(Icons.info, color: Colors.orange),
                    SizedBox(width: 8),
                    Text('带详细描述的选项',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 32, top: 4),
                  child: Text(
                    '这里是详细的描述信息，可以很长很长...',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );

    if (selected != null) {
      setState(() {
        _selectedAction = '宽度菜单选择了: $selected';
      });
    }
  }

  // 显示右键上下文菜单
  void _showContextMenu(BuildContext context, Offset globalPosition) async {
    final RenderBox overlay =
        Overlay.of(context)!.context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      globalPosition & Size.zero,
      Offset.zero & overlay.size,
    );

    final String? selected = await showMenu<String>(
      context: context,
      position: position,
      items: <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: '查看',
          child: ListTile(
            leading: Icon(Icons.visibility),
            title: Text('查看'),
            dense: true,
          ),
        ),
        PopupMenuItem<String>(
          value: '编辑',
          child: ListTile(
            leading: Icon(Icons.edit),
            title: Text('编辑'),
            dense: true,
          ),
        ),
        PopupMenuDivider(),
        PopupMenuItem<String>(
          value: '删除',
          child: ListTile(
            leading: Icon(Icons.delete, color: Colors.red),
            title: Text('删除', style: TextStyle(color: Colors.red)),
            dense: true,
          ),
        ),
      ],
    );

    if (selected != null) {
      setState(() {
        _contextMenuResult = '右键菜单选择了: $selected';
      });
    }
  }

  // 在中心显示上下文菜单（用于移动设备）
  void _showContextMenuAtCenter(BuildContext context) async {
    final String? selected = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(100, 200, 100, 200), // 大致居中位置
      items: <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: '查看详情',
          child: ListTile(
            leading: Icon(Icons.info),
            title: Text('查看详情'),
            dense: true,
          ),
        ),
        PopupMenuItem<String>(
          value: '分享',
          child: ListTile(
            leading: Icon(Icons.share),
            title: Text('分享'),
            dense: true,
          ),
        ),
        PopupMenuItem<String>(
          value: '收藏',
          child: ListTile(
            leading: Icon(Icons.bookmark),
            title: Text('收藏'),
            dense: true,
          ),
        ),
      ],
    );

    if (selected != null) {
      setState(() {
        _contextMenuResult = '长按菜单选择了: $selected';
      });
    }
  }
}
