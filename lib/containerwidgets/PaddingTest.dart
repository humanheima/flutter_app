import 'package:flutter/material.dart';

///
/// Crete by dumingwei on 2019/3/19
/// Desc: Padding ConstrainedBox和SizedBox,UnconstrainedBox，
/// DecoratedBox DecoratedBox可以在其子widget绘制前(或后)绘制一个装饰Decoration（如背景、边框、渐变等）
///

class PaddingTestRoute extends StatelessWidget {
  Widget redBox = DecoratedBox(decoration: BoxDecoration(color: Colors.red));
  Widget greenBox =
      DecoratedBox(decoration: BoxDecoration(color: Colors.green));

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Padding"),
      ),
      body: Padding(
        //上下左右各添加16像素补白
        padding: EdgeInsets.all(16.0),
        child: Column(
          //显式指定对齐方式为左对齐，排除对齐干扰
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              //左边添加8像素补白
              padding: const EdgeInsets.only(left: 8.0),
              child: Text("Hello world"),
            ),
            Padding(
              //上下各添加8像素补白
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text("I am Jack"),
            ),
            Padding(
              // 分别指定四个方向的补白
              padding: const EdgeInsets.fromLTRB(20.0, .0, 20.0, 20.0),
              child: Text("Your friend"),
            ),
            ConstrainedBox(
                child: Container(
                  height: 5.0,
                  child: redBox,
                ),
                constraints:
                    BoxConstraints(minWidth: double.infinity, minHeight: 50.0)),
            SizedBox(width: 80.0, height: 80.0, child: greenBox),
            ConstrainedBox(
                constraints: BoxConstraints(minWidth: 60.0, minHeight: 100.0),
                //父
                child: UnconstrainedBox(
                  //“去除”父级限制
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minWidth: 90.0, minHeight: 20.0), //子
                    child: redBox,
                  ),
                )),
            DecoratedBox(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.red, Colors.orange[700]]), //背景渐变
                    borderRadius: BorderRadius.circular(3.0), //3像素圆角
                    boxShadow: [
                      //阴影
                      BoxShadow(
                          color: Colors.black54,
                          offset: Offset(2.0, 2.0),
                          blurRadius: 4.0)
                    ]),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
