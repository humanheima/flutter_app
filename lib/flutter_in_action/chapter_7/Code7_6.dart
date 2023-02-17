import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

///
/// Created by dumingwei on 2019-10-09.
/// Desc:
///
class Code7_6 extends StatelessWidget {
  bool withTree = false; // 复选框选中状态

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('7.6 对话框详解'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: RaisedButton(
                child: Text('对话框1'),
                onPressed: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('提示'),
                          content: Text('您确定要删除当前文件吗?'),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('取消')),
                            FlatButton(
                              child: Text("删除"),
                              onPressed: () {
                                // ... 执行删除操作
                                Navigator.of(context).pop(true); //关闭对话框
                              },
                            ),
                          ],
                        );
                      });
                }),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: RaisedButton(
                child: Text('对话框2'),
                onPressed: () async {
                  bool delete = await showDeleteConfirmDialog1(context);
                  if (delete == null) {
                    print("取消删除");
                  } else {
                    print("已确认删除");
                  }
                }),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: RaisedButton(
                child: Text('SimpleDialog'),
                onPressed: () {
                  changeLanguage(context);
                }),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: RaisedButton(
                child: Text('showListDialog'),
                onPressed: () {
                  showListDialog(context);
                }),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: RaisedButton(
                child: Text('showCustomDialog'),
                onPressed: () {
                  showCustomDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("提示"),
                          content: Text("您确定要删除当前文件吗?"),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("取消"),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            FlatButton(
                              child: Text("删除"),
                              onPressed: () {
                                // 执行删除操作
                                Navigator.of(context).pop(true);
                              },
                            ),
                          ],
                        );
                      });
                }),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: RaisedButton(
                child: Text('testChangeDialogState'),
                onPressed: () async {
                  //弹出删除确认对话框，等待用户确认
                  bool deleteTree = await showDeleteConfirmDialog3(context);
                  if (deleteTree == null) {
                    print("取消删除");
                  } else {
                    print("同时删除子目录: $deleteTree");
                  }
                }),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: RaisedButton(
                child: Text('testChangeDialogState1'),
                onPressed: () async {
                  //弹出删除确认对话框，等待用户确认
                  bool deleteTree = await showDeleteConfirmDialog4(context);
                  if (deleteTree == null) {
                    print("取消删除");
                  } else {
                    print("同时删除子目录: $deleteTree");
                  }
                }),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: RaisedButton(
                child: Text('testChangeDialogState2'),
                onPressed: () async {
                  //弹出删除确认对话框，等待用户确认
                  bool deleteTree = await showDeleteConfirmDialog5(context);
                  if (deleteTree == null) {
                    print("取消删除");
                  } else {
                    print("同时删除子目录: $deleteTree");
                  }
                }),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: RaisedButton(
                child: Text('显示底部弹出框'),
                onPressed: () async {
                  //弹出删除确认对话框，等待用户确认
                  int type = await _showModalBottomsheet(context);
                  print(type);
                }),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: RaisedButton(
                child: Text('显示底部弹出框1'),
                onPressed: () async {
                  //弹出删除确认对话框，等待用户确认
                  _showBottomSheet(context);
                }),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: RaisedButton(
                child: Text('展示LoadingDialog'),
                onPressed: () async {
                  //弹出删除确认对话框，等待用户确认
                  showLoadingDialog(context);
                }),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: RaisedButton(
                child: Text('展示LoadingDialog1,修改尺寸'),
                onPressed: () async {
                  //弹出删除确认对话框，等待用户确认
                  showLoadingDialog1(context);
                }),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: RaisedButton(
                child: Text('日历选择'),
                onPressed: () async {
                  //弹出删除确认对话框，等待用户确认
                  _showDatePicker1(context);
                }),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: RaisedButton(
                child: Text('ios风格日历选择'),
                onPressed: () async {
                  //弹出删除确认对话框，等待用户确认
                  _showDatePicker2(context);
                }),
          ),
        ],
      ),
    );
  }

  Future<DateTime> _showDatePicker1(BuildContext context) {
    var date = DateTime.now();
    return showDatePicker(
      context: context,
      initialDate: date,
      firstDate: date,
      lastDate: date.add(
        //未来30天可选
        Duration(days: 30),
      ),
    );
  }

  Future<DateTime> _showDatePicker2(BuildContext context) {
    var date = DateTime.now();
    return showCupertinoModalPopup(
      context: context,
      builder: (ctx) {
        return SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.dateAndTime,
            minimumDate: date,
            maximumDate: date.add(
              Duration(days: 30),
            ),
            maximumYear: date.year + 1,
            onDateTimeChanged: (DateTime value) {
              print(value);
            },
          ),
        );
      },
    );
  }

  showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, //点击遮罩不关闭对话框
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.only(top: 26.0),
                child: Text("正在加载，请稍后..."),
              )
            ],
          ),
        );
      },
    );
  }

  ///修改弹出框尺寸
  showLoadingDialog1(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, //点击遮罩不关闭对话框
      builder: (context) {
        return UnconstrainedBox(
          child: SizedBox(
              width: 280,
              child: AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: const EdgeInsets.only(top: 26.0),
                      child: Text("正在加载，请稍后..."),
                    )
                  ],
                ),
              )),
        );
      },
    );
  }

  // 弹出对话框
  Future<bool> showDeleteConfirmDialog1(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Text("您确定要删除当前文件吗?"),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(), // 关闭对话框
            ),
            FlatButton(
              child: Text("删除"),
              onPressed: () {
                //关闭对话框并返回true
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> changeLanguage(BuildContext context) async {
    int i = await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('请选择语言'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  // 返回1
                  Navigator.pop(context, 1);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: const Text('中文简体'),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  // 返回2
                  Navigator.pop(context, 2);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: const Text('英语'),
                ),
              ),
            ],
          );
        });
    if (i != null) {
      print("选择了：${i == 1 ? "中文简体" : "美国英语"}");
    }
  }

  Future<void> showListDialog(BuildContext context) async {
    int index = await showDialog(
        context: context,
        builder: (BuildContext context) {
          var child = Column(
            children: <Widget>[
              ListTile(
                title: Text('请选择'),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: 30,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text('$index'),
                          onTap: () => Navigator.of(context).pop(index),
                        );
                      })),
            ],
          );
          return Dialog(
            child: child,
          );
        });
    if (index != null) {
      print("点击了：$index");
    }
  }

  Future<T> showCustomDialog<T>(
      {@required BuildContext context,
      bool barrierDismissible = true,
      WidgetBuilder builder}) {
    final ThemeData theme = Theme.of(context);
    return showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        final Widget pageChild = Builder(builder: builder);
        return SafeArea(child: Builder(builder: (BuildContext context) {
          return theme != null
              ? Theme(data: theme, child: pageChild)
              : pageChild;
        }));
      },
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black87,
      transitionDuration: const Duration(milliseconds: 150),
      transitionBuilder: _buildMaterialDialogTransitions,
    );
  }

  Widget _buildMaterialDialogTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    // 使用缩放动画
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      child: child,
    );
  }

  Future<bool> showDeleteConfirmDialog3(BuildContext context) {
    bool _withTree = false; //记录复选框是否选中
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("您确定要删除当前文件吗?"),
              Row(
                children: <Widget>[
                  Text("同时删除子目录？"),
                  DialogCheckbox(
                    value: _withTree, //默认不选中
                    onChanged: (bool value) {
                      //更新选中状态
                      _withTree = !_withTree;
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text("删除"),
              onPressed: () {
                // 将选中状态返回
                Navigator.of(context).pop(_withTree);
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> showDeleteConfirmDialog4(BuildContext context) {
    bool _withTree = false; //记录复选框是否选中
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("您确定要删除当前文件吗?"),
              Row(
                children: <Widget>[
                  Text("同时删除子目录？"),
                  StatefulBuilder(builder: (context, _setState) {
                    return Checkbox(
                        value: _withTree,
                        onChanged: (bool value) {
                          _setState(() {
                            _withTree = !_withTree;
                          });
                        });
                  }),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text("删除"),
              onPressed: () {
                // 将选中状态返回
                Navigator.of(context).pop(_withTree);
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> showDeleteConfirmDialog5(BuildContext context) {
    bool _withTree = false;
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("您确定要删除当前文件吗?"),
              Row(
                children: <Widget>[
                  Text("同时删除子目录？"),
                  Checkbox(
                    // 依然使用Checkbox组件
                    value: _withTree,
                    onChanged: (bool value) {
                      // 此时context为对话框UI的根Element，我们
                      // 直接将对话框UI对应的Element标记为dirty
                      (context as Element).markNeedsBuild();
                      _withTree = !_withTree;
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text("删除"),
              onPressed: () {
                // 执行删除操作
                Navigator.of(context).pop(_withTree);
              },
            ),
          ],
        );
      },
    );
  }

  Future<int> _showModalBottomsheet(BuildContext context) {
    return showModalBottomSheet<int>(
        context: context,
        builder: (BuildContext context) {
          return ListView.builder(
              itemCount: 30,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('$index'),
                  onTap: () => Navigator.of(context).pop(index),
                );
              });
        });
  }

  // 返回的是一个controller,这个展示不出来
  PersistentBottomSheetController<int> _showBottomSheet(BuildContext context) {
    return showBottomSheet<int>(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: 30,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text("$index"),
              onTap: () {
                // do something
                print("$index");
                Navigator.of(context).pop();
              },
            );
          },
        );
      },
    );
  }
}

class DialogCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  _DialogCheckboxState createState() {
    return _DialogCheckboxState();
  }

  DialogCheckbox({Key key, this.value, this.onChanged});
}

class _DialogCheckboxState extends State<DialogCheckbox> {
  bool value;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: value,
        onChanged: (v) {
          widget.onChanged(v);
          setState(() {
            value = v;
          });
        });
  }
}

Future<bool> showDeleteConfirmDialog3(BuildContext context) {
  bool _withTree = false; //记录复选框是否选中
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("提示"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("您确定要删除当前文件吗?"),
            Row(
              children: <Widget>[
                Text("同时删除子目录？"),
                DialogCheckbox(
                  value: _withTree, //默认不选中
                  onChanged: (bool value) {
                    //更新选中状态
                    _withTree = !_withTree;
                  },
                ),
              ],
            ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text("取消"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FlatButton(
            child: Text("删除"),
            onPressed: () {
              // 将选中状态返回
              Navigator.of(context).pop(_withTree);
            },
          ),
        ],
      );
    },
  );
}

/*
class StatefulBuilder extends StatefulWidget {
  const StatefulBuilder({
    Key key,
    @required this.builder,
  })
      : assert(builder != null),
        super(key: key);

  final StatefulWidgetBuilder builder;

  @override
  _StatefulBuilderState createState() => _StatefulBuilderState();
}

class _StatefulBuilderState extends State<StatefulBuilder> {
  @override
  Widget build(BuildContext context) => widget.builder(context, setState);
}
*/
