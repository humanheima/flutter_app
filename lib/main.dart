// This sample shows adding an action to an [AppBar] that opens a shopping cart.

import 'package:flutter/material.dart';
import 'package:flutter_app/enjoy/view/wechat_article_page.dart';
import 'package:flutter_app/package_manage.dart';
import 'package:flutter_app/wanandroid_flutter/wanandroid_flutter_main.dart';

import 'LearnWidget.dart';
import 'enjoy/view/home_page.dart';
import 'enjoy/view/project_practice_page.dart';

/// 程序入口

void main() => runApp(WanAndroidApp(false));

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
            MyHomePage(title: "你好"),
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
                  title: Text('基础知识'), icon: Icon(Icons.shopping_basket)),
              BottomNavigationBarItem(
                  title: Text('推荐'), icon: Icon(Icons.home)),
              BottomNavigationBarItem(title: Text('项目'), icon: Icon(Icons.map)),
              BottomNavigationBarItem(
                  title: Text('公众号'), icon: Icon(Icons.contact_mail)),
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

/*class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}*/

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline1,
            ),
            FlatButton(
              child: Text("open new route"),
              textColor: Colors.blue,
              onPressed: () {
                /* Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return new NewRoute();
                }));*/

                debugPrint("通过路由名来打开新的路由");

                ///通过路由名来打开新的路由
                Navigator.pushNamed(context, "new_page");
              },
            ),
            RandomWordsWidget()
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

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
