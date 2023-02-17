import 'package:flutter/material.dart';

///
/// Created by dumingwei on 2019/4/13.
/// Desc:
///

class BottomNavigationBarWidget extends StatefulWidget {
  final int index;
  final ValueChanged<int> onChanged;

  BottomNavigationBarWidget({Key key, this.index: 0, this.onChanged})
      : super(key: key);

  @override
  State createState() {
    return BottomNavigationBarWidgetState();
  }
}

class BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget>
    with AutomaticKeepAliveClientMixin {
  int _currentIndex = 0;

  void _onTapHandler(int index) {
    setState(() {
      _currentIndex = index;
    });
    widget.onChanged(index);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: _onTapHandler,
      type: BottomNavigationBarType.fixed,
      fixedColor: Colors.blue,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
        BottomNavigationBarItem(icon: Icon(Icons.streetview), label: '体系'),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: '公众号'),
        BottomNavigationBarItem(icon: Icon(Icons.navigation), label: '导航'),
        BottomNavigationBarItem(icon: Icon(Icons.apps), label: '项目'),
      ],
    );
  }

  @override
  bool get wantKeepAlive {
    return true;
  }
}
