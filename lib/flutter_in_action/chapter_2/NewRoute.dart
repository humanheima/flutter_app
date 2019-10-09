import 'package:flutter/material.dart';

///
/// Created by dumingwei on 2019-09-12.
/// Desc:
///

class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New route'),
      ),
      body: Center(
        child: Text('This is new route'),
      ),
    );
  }
}
