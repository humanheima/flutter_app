import 'package:flutter/material.dart';

///
/// Created by dumingwei on 2019-10-07.
/// Desc:3.6 单选开关和复选框
///
class SwitchAndCheckBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('3.6 单选开关和复选框'),
      ),
      body: new Container(
        child: new ListView(
          children: <Widget>[
            SwitchAndCheckBoxWidget(),
          ],
        ),
      ),
    );
  }
}

class SwitchAndCheckBoxWidget extends StatefulWidget {
  @override
  _SwitchAndCheckBoxWidgetState createState() =>
      new _SwitchAndCheckBoxWidgetState();
}

class _SwitchAndCheckBoxWidgetState extends State<SwitchAndCheckBoxWidget> {
  bool _switchSelected = true; //维护单选开关状态
  bool _checkboxSelected = true; //维护复选框状态
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        children: <Widget>[
          Switch(
            value: _switchSelected, //当前状态
            onChanged: (value) {
              //重新构建页面
              setState(() {
                _switchSelected = value;
              });
            },
          ),
          Checkbox(
            value: _checkboxSelected,
            activeColor: Colors.red, //选中时的颜色
            onChanged: (value) {
              setState(() {
                _checkboxSelected = value;
              });
            },
          )
        ],
      ),
    );
  }
}
