import 'package:flutter/material.dart';
import 'HeroAnimationRouteB.dart';

///
/// Crete by dumingwei on 2019/3/27
/// Desc: Hero动画，即元素共享动画
///

///路由A
class HeroAnimationRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: 40.0),
        child: InkWell(

            child: Hero(
                tag: "avatar",
                child: ClipOval(
                  child: Image.asset(
                    "images/avatar.png",
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
                    body: HeroAnimationRouteB(),
                  ),
                );
              })));
            }),
      ),
    );
  }
}
