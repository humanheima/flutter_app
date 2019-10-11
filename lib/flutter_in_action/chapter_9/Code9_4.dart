import 'package:flutter/material.dart';

/// Crete by dumingwei on 2019/3/27
/// Desc: Hero动画，即元素共享动画
///

///路由A
class HeroAnimationRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('9.4 Hero动画小图'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: 40.0),
        child: InkWell(
            child: Hero(
                tag: "avatar",
                child: ClipOval(
                  child: Image.asset(
                    "images/avatar.jpg",
                    width: 50.0,
                  ),
                )),
            onTap: () {
              //打开B路由
              Navigator.push(context, PageRouteBuilder(pageBuilder:
                  ((BuildContext context, Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                return new FadeTransition(
                  opacity: animation,
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text('9.4 Hero动画原图'),
                    ),
                    body: HeroAnimationRouteB(),
                  ),
                );
              })));
            }),
      ),
    );
  }
}

class HeroAnimationRouteB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: "avatar", //唯一标记，前后两个路由页Hero的tag必须相同
        child: Image.asset("images/avatar.jpg"),
      ),
    );
  }
}
