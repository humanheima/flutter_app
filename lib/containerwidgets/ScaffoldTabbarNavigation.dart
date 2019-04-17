import 'package:flutter/material.dart';

///
/// Crete by dumingwei on 2019/3/19
/// Desc: Padding ConstrainedBox和SizedBox,UnconstrainedBox，
/// DecoratedBox DecoratedBox可以在其子widget绘制前(或后)绘制一个装饰Decoration（如背景、边框、渐变等）
///

class ScaffoldRoute extends StatefulWidget {
  @override
  _ScaffoldRouteState createState() {
    return _ScaffoldRouteState();
  }
}

class _ScaffoldRouteState extends State<ScaffoldRoute>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<String> tabs = ["新闻", "history", "image"];
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        //导航栏
        title: Text("App name"),
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.dashboard, color: Colors.white),
            onPressed: () {
              //打开抽屉菜单
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        actions: <Widget>[
          //导航栏右侧菜单
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          )
        ],
        bottom: TabBar(
          tabs: tabs.map((e) => Tab(text: e)).toList(),
          controller: _tabController,
        ),
      ),
      drawer: new MyDrawer(),
      body: TabBarView(
          controller: _tabController,
          children: tabs.map((e) {
            return Container(
                alignment: Alignment.center,
                child: Text(
                  e,
                  textScaleFactor: 5,
                ));
          }).toList()),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.business), title: Text('Businiss')),
          BottomNavigationBarItem(
              icon: Icon(Icons.school), title: Text('School')),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.blue,
        onTap: _onItemTapped,
      ),
      /* bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Colors.white,
        child: Row(
          children: [
            Center(child: IconButton(icon: Icon(Icons.home))),
            SizedBox(), //中间位置空出
            IconButton(icon: Icon(Icons.business)),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround, //均分底部导航栏横向空间
        ),
      ),*/
      floatingActionButton: FloatingActionButton(
        onPressed: _onAdd,
        child: Icon(Icons.add),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onAdd() {}
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 38.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ClipOval(
                        child: Image.asset(
                          "images/avatar.png",
                          width: 80.0,
                        ),
                      ),
                    ),
                    Text(
                      "Wendux",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.add),
                      title: const Text('Add account'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text('Manage accounts'),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
