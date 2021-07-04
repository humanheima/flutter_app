import 'package:flutter/material.dart';
import 'InsuranceOrderDetailWidget.dart';

///
/// Created by dumingwei on 2019-10-22.
/// Desc:
///
class PracticeHomepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('练习'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              Navigator.push(context, new MaterialPageRoute(builder: (context) {
                return InsuranceOrderDetailWidget();
              }));
            },
            child: Text('保单详情'),
          )
        ],
      ),
    );
  }
}
