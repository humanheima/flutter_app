import 'package:flutter/material.dart';
import 'package:flutter_app/enjoy_android/view/home_page.dart';
import 'package:flutter_app/enjoy_android/view/project_practice_page.dart';
import 'package:flutter_app/enjoy_android/view/wechat_article_page.dart';

///
/// Created by dumingwei on 2019-10-17.
/// Desc:
///
class EnjoyAndroidMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EnjoyAndroidApp();
  }
}

class EnjoyAndroidApp extends StatefulWidget {
  @override
  State createState() {
    return _EnjoyAndroidAppState();
  }
}

class _EnjoyAndroidAppState extends State<EnjoyAndroidApp> {
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
