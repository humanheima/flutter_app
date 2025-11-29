import 'package:flutter/material.dart';

import 'PureImageCheckbox.dart';

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
            onChanged: (bool? value) {
              setState(() {
                _checkboxSelected = value ?? false;
              });
            },
          ),

          // 示例 2：自定义图片大小+初始选中+禁用状态
          PureImageCheckbox(
            uncheckedImagePath: "images/unchecked2.png",
            checkedImagePath: "images/checked2.png",
            imageWidth: 32, // 图片宽度 32px
            imageHeight: 32, // 图片高度 32px
            initialChecked: true, // 初始选中
            isDisabled: false, // 不禁用
            onCheckedChanged: (isChecked) {
              print("自定义大小复选框：$isChecked");
            },
          ),

          const SizedBox(height: 20),

          // 示例 3：禁用状态（图片置灰，不可点击）
          PureImageCheckbox(
            uncheckedImagePath: "images/unchecked.png",
            checkedImagePath: "images/checked.png",
            isDisabled: true, // 禁用
          ),

        ],
      ),
    );
  }
}
