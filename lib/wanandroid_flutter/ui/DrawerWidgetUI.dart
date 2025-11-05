import 'package:flutter/material.dart';
import 'package:flutter_app/wanandroid_flutter/GlobalConfig.dart';
import 'package:flutter_app/wanandroid_flutter/common/User.dart';
import 'package:flutter_app/wanandroid_flutter/common/application.dart';
import 'package:flutter_app/wanandroid_flutter/event/login_event.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/wanandroid_flutter/event/theme_change_event.dart';
import 'package:flutter_app/wanandroid_flutter/ui/AboutAppPageUI.dart';
import 'package:flutter_app/wanandroid_flutter/ui/account/LoginPageUI.dart';

///
/// Created by dumingwei on 2019/4/13.
/// Desc:
///

class DrawerWidgetUI extends StatefulWidget {
  @override
  State createState() => DrawerWidgetUIState();
}

class DrawerWidgetUIState extends State<DrawerWidgetUI> {
  @override
  void initState() {
    super.initState();
    Application.eventBus
        .on<LoginEvent>()
        .listen((LoginEvent onData) => this.changeUI());
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: InkWell(
              child: Text(
                  User.singleton.userName.isNotEmpty
                      ? User.singleton.userName
                      : '未登录',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                return null;
                            },
            ),
            accountEmail: null,
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('images/avatar.jpg'),
            ),
            decoration: BoxDecoration(
                color: Colors.grey.shade800,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.grey.shade800.withValues(alpha: 0.6), BlendMode.hardLight),
                    image: AssetImage(GlobalConfig.dark
                        ? 'images/bg_dark.png'
                        : 'images/bg_light.jpg'))),
          ),
          ListTile(
            title: Text(
              '我的收藏',
              textAlign: TextAlign.left,
            ),
            leading: Icon(
              Icons.collections,
              color: GlobalConfig.themeData.colorScheme.secondary,
              size: 22.0,
            ),
            onTap: () {
              onCollectionClick();
                        },
          ),
          ListTile(
            title: Text(
              '常用网站',
              textAlign: TextAlign.left,
            ),
            leading: Icon(Icons.web,
                color: GlobalConfig.themeData.colorScheme.secondary, size: 22.0),
            onTap: () {
              onWebsiteCollectionClick();
                        },
          ),
          ListTile(
            title: Text(
              'TODO',
              textAlign: TextAlign.left,
            ),
            leading: Icon(Icons.today,
                color: GlobalConfig.themeData.colorScheme.secondary, size: 22.0),
            onTap: () {
              onTodoClick();
                        },
          ),
          ListTile(
            title: Text(
              GlobalConfig.dark ? '日间模式' : '夜间模式',
              textAlign: TextAlign.left,
            ),
            leading: Icon(Icons.wb_sunny,
                color: GlobalConfig.themeData.colorScheme.secondary, size: 22.0),
            onTap: () {
              setState(() {
                if (GlobalConfig.dark == true) {
                  GlobalConfig.dark = false;
                } else {
                  GlobalConfig.dark = true;
                }
                changeTheme();
              });
            },
          ),
          ListTile(
            title: Text(
              '设置',
              textAlign: TextAlign.left,
            ),
            leading: Icon(Icons.settings_applications,
                color: GlobalConfig.themeData.colorScheme.secondary, size: 22.0),
            onTap: () {
//              Navigator.pop(context);
              Fluttertoast.showToast(msg: "该功能暂未上线~");
            },
          ),
          ListTile(
            title: Text(
              '关于App',
              textAlign: TextAlign.left,
            ),
            leading: Icon(Icons.people,
                color: GlobalConfig.themeData.colorScheme.secondary, size: 22.0),
            onTap: () {
              onAboutClick();
              Scaffold.of(context).openEndDrawer();
            },
          ),
          const SizedBox(height: 24.0),
          logoutWidget(),
        ],
      ),
    );
  }

  changeUI() async {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onLoginClick() async {
    await Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return LoginPageUI();
    }));
  }

  void onCollectionClick() {}

  void onWebsiteCollectionClick() {}

  void onTodoClick() {}

  void changeTheme() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool("darkTheme", GlobalConfig.dark);
    Application.eventBus.fire(new ThemeChangeEvent(GlobalConfig.dark));
  }

  void onAboutClick() async {
    await Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return AboutAppPageUI();
    }));
  }

  Widget logoutWidget() {
    return Center(
      child: TextButton(
          onPressed: () {
            User.singleton.clearUserInfo();
            setState(() {});
          },
          child: Text(
            '退出登录',
            style: TextStyle(color: Colors.red),
          )),
    );
    }
}
