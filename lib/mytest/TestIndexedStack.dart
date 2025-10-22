import 'package:flutter/material.dart';

///
/// Created by dumingwei on 2019/4/17.
/// Desc:测试IndexedStack
///

class TestIndexedStack extends StatefulWidget {
  @override
  State createState() {
    return TestIndexedStackState();
  }
}

class TestIndexedStackState extends State<TestIndexedStack> {
  List<Widget> wigets = [];

  int _index = 0;

  @override
  void initState() {
    super.initState();
    wigets = [];
    wigets.add(Container(
      width: 300,
      height: 300,
      child: Text('first'),
      color: Colors.black26,
    ));
    wigets.add(Container(
      width: 300,
      height: 300,
      child: Text('first'),
      color: Colors.green,
    ));
    wigets.add(Container(
      width: 300,
      height: 300,
      child: Text('first'),
      color: Colors.blue,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: wigets,
        index: _index,
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _index,
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.deepPurpleAccent,
          onTap: (index) => _tab(index),
          items: [
            BottomNavigationBarItem(
                label: 'first', icon: Icon(Icons.shopping_basket)),
            BottomNavigationBarItem(label: 'second', icon: Icon(Icons.home)),
            BottomNavigationBarItem(label: 'third', icon: Icon(Icons.map))
          ]),
    );
  }

  _tab(int index) {
    setState(() {
      _index = index;
    });
  }
}
