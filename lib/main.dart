// This sample shows adding an action to an [AppBar] that opens a shopping cart.

import 'package:flutter/material.dart';
import 'package:flutter_app/enjoy/view/wechat_article_page.dart';
import 'package:flutter_app/package_manage.dart';

import 'enjoy/view/home_page.dart';
import 'enjoy/view/project_practice_page.dart';
import 'enjoy/view/recommend/project_practice_page2.dart';

/// 程序入口

/*void main() => runApp(WanAndroidApp(false));*/

// void main() => runApp(App());

class App extends StatefulWidget {
  @override
  State createState() {
    return _AppState();
  }
}

class _AppState extends State<App> {
  var _pageController;
  int _tabIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, keepPage: true);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(), //让pageView不能滑动
          children: <Widget>[
            //MyHomePage(title: "你好"),
            ProjectPracticePage2(),
            HomePage(),
            ProjectPracticePage(),
            WechatArticlePage()
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _tabIndex,
            type: BottomNavigationBarType.fixed,
            fixedColor: Colors.deepPurpleAccent,
            onTap: (index) => _tab(index),
            items: [
              BottomNavigationBarItem(
                  label: '基础知识', icon: Icon(Icons.shopping_basket)),
              BottomNavigationBarItem(label: '推荐', icon: Icon(Icons.home)),
              BottomNavigationBarItem(label: '项目', icon: Icon(Icons.map)),
              BottomNavigationBarItem(
                  label: '公众号', icon: Icon(Icons.contact_mail)),
            ]),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _tab(int index) {
    setState(() {
      _tabIndex = index;
      _pageController.jumpToPage(index);
    });
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      ///应用名称
      title: 'Flutter Code Sample for material.AppBar.actions',

      ///主题
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      //注册路由表
      routes: {"new_page": (context) => NewRoute()},

      ///应用首页路由
      home: MyHomePage(
        title: "Flutter Demo Home Page",
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:'),
            Text('$_counter',
                style: Theme.of(context).textTheme.headlineMedium),
            TextButton(
              child: Text("open new route"),
              onPressed: () {
                debugPrint("通过路由名来打开新的路由");
                Navigator.pushNamed(context, "new_page");
              },
            ),
            RandomWordsWidget()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello World'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            tooltip: 'Open shopping cart',
            onPressed: () {
              // ...
            },
          ),
        ],
      ),
    );
  }
}

class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("new route"),
      ),
      body: Center(
        child: Text("This is new route"),
      ),
    );
  }
}

// Entry point for the app. Use a minimal, self-contained app to ensure it runs.
//void main() => runApp(const BootstrapApp());

/// A minimal bootstrap app to get the project running while legacy modules are migrated.
class BootstrapApp extends StatelessWidget {
  const BootstrapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const _BootstrapHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class _BootstrapHome extends StatefulWidget {
  const _BootstrapHome();

  @override
  State<_BootstrapHome> createState() => _BootstrapHomeState();
}

class _BootstrapHomeState extends State<_BootstrapHome> {
  int _index = 0;
  static const _tabs = ['基础', '推荐', '项目', '公众号'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter App - ${_tabs[_index]}')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              [Icons.school, Icons.home, Icons.map, Icons.contact_mail][_index],
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text('占位页面（待迁移原有页面）',
                style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepPurpleAccent,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(
              label: '基础知识', icon: Icon(Icons.shopping_basket)),
          BottomNavigationBarItem(label: '推荐', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: '项目', icon: Icon(Icons.map)),
          BottomNavigationBarItem(label: '公众号', icon: Icon(Icons.contact_mail)),
        ],
      ),
    );
  }
}

// NOTE:
// - Legacy imports and widgets in this file referenced non-null-safe modules across lib/.
// - To ensure `flutter run` succeeds, we use this minimal bootstrap app and avoid importing legacy files.
// - Original code below remains unchanged for future migration.
