import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/wanandroid_flutter/GlobalConfig.dart';
import 'package:flutter_app/wanandroid_flutter/common/application.dart';
import 'package:flutter_app/wanandroid_flutter/event/theme_change_event.dart';
import 'package:flutter_app/wanandroid_flutter/ui/DrawerWidgetUI.dart';
import 'package:flutter_app/wanandroid_flutter/ui/HomePageUI.dart';
import 'package:flutter_app/wanandroid_flutter/ui/NaviPageUI.dart';
import 'package:flutter_app/wanandroid_flutter/ui/ProjectTreePageUI.dart';
import 'package:flutter_app/wanandroid_flutter/ui/SearchPageUI.dart';
import 'package:flutter_app/wanandroid_flutter/ui/SystemTreeUI.dart';
import 'package:flutter_app/wanandroid_flutter/ui/WxArticlePageUI.dart';
import 'package:flutter_app/wanandroid_flutter/widget/BottomNavigationBarWidget.dart';

///
/// Created by dumingwei on 2019/4/12.
/// Desc: 玩安卓入口
///

class WanAndroidApp extends StatefulWidget {
  ///是否是暗色主题
  final bool darkTheme;

  WanAndroidApp(this.darkTheme);

  @override
  State createState() => WanAndroidAppState();
}

class WanAndroidAppState extends State<WanAndroidApp> {
  late ThemeData themeData;

  @override
  void initState() {
    super.initState();
    Application.eventBus = new EventBus();
    themeData = GlobalConfig.geThemeData(widget.darkTheme);
    registerThemeEvent();
  }

  ///监听theme改变事件
  void registerThemeEvent() {
    Application.eventBus
        .on<ThemeChangeEvent>()
        .listen((ThemeChangeEvent onData) => changeTheme(onData));
  }

  void changeTheme(ThemeChangeEvent onData) {
    setState(() {
      themeData = GlobalConfig.geThemeData(onData.dark);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "模仿玩安卓",
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    Application.eventBus.destroy();
  }
}

class Home extends StatefulWidget {
  @override
  State createState() => HomeState();
}

class HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  int _index = 0;

  late PageController _pageController;
  var _pageList;
  List<String> _titleList = [
    "首页",
    "知识体系",
    "公众号",
    "导航",
    "项目",
  ];

  bool _showAppbar = true;
  bool _showDrawer = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, keepPage: true);
    _pageList = [
      HomePageUI(),
      SystemTreeUI(),
      WxArticlePageUI(),
      NaviPageUI(),
      ProjectTreePageUI(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // Required when using AutomaticKeepAliveClientMixin
    super.build(context);
    print('index=$_index');
    /* return MaterialApp(
      home: Scaffold(
        appBar: _appBarWidget(context),
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: _pageList,
        ),
        bottomNavigationBar: BottomNavigationBarWidget(
          index: _index,
          onChanged: _handleTabChanged,
        ),
      ),
    );*/

    return WillPopScope(
        child: DefaultTabController(
            length: _titleList.length,
            child: Scaffold(
              appBar: _showAppbar ? _appBarWidget(context) : null,
              body: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                children: _pageList,
              ),
              drawer: _showDrawer ? DrawerWidgetUI() : null,
              bottomNavigationBar: BottomNavigationBarWidget(
                index: _index,
                onChanged: _handleTabChanged,
              ),
            )),
        onWillPop: _onWillPop);
  }

  @override
  bool get wantKeepAlive {
    return true;
  }

  _appBarWidget(BuildContext context) {
    return AppBar(
      title: Text(_titleList[_index]),
      elevation: 0.4,
      actions: _actionsWidget(),
    );
  }

  _actionsWidget() {
    if (_showDrawer) {
      return [
        new IconButton(
            icon: new Icon(Icons.search),
            onPressed: () {
              onSearchClick();
            })
      ];
    } else {
      return null;
    }
  }

  void onSearchClick() async {
    await Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new SearchPageUI();
    }));
  }

  Future<bool> _onWillPop() async {
    final bool? result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("提示"),
          content: Text("确定退出应用吗？"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('再看一会'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('退出'),
            ),
          ],
        );
      },
    );

    return result ?? false;
  }

  void _handleTabChanged(int newValue) {
    setState(() {
      _index = newValue;
      _pageController.jumpToPage(_index);
      if (_index == 0 || _index == 1 || _index == 3) {
        _showAppbar = true;
      } else {
        _showAppbar = false;
      }
      if (_index == 0) {
        _showDrawer = true;
      } else {
        _showDrawer = false;
      }
    });
  }
}
