import 'package:flutter/material.dart';
import 'scrollable_tabbar_example.dart';
import 'non_scrollable_tabbar_example.dart';
import 'dialog_tabbar_example.dart';
import 'dialog_tabbar_example2.dart' as example2;
import 'dialog_tabbar_example3.dart' as example3;

void main() => runApp(TabBarDemoApp());

class TabBarDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TabBar Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TabBarDemoHome(),
    );
  }
}

class TabBarDemoHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TabBar 使用示例'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ScrollableTabBarExample()),
                );
              },
              child: Text('例子1：可滚动的 TabBar'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NonScrollableTabBarExample()),
                );
              },
              child: Text('例子2：不可滚动的 TabBar'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showTabBarDialog(context);
              },
              child: Text('例子3：弹窗中的 TabBar'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                example2.showTabBarDialog(context);
              },
              child: Text('例子4：自适应高度的弹窗 TabBar'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                example3.showTabBarDialog(context);
              },
              child: Text('例子5：只有一个 tab 的自适应高度弹窗 TabBar'),
            ),
          ],
        ),
      ),
    );
  }
}
