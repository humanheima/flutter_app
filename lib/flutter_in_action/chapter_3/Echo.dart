import 'package:flutter/material.dart';

///
/// Created by dumingwei on 2019-09-30.
/// Desc:
///

class Echo extends StatelessWidget {
  final String text;
  final Color? backgroundColor;

  const Echo({Key? key, required this.text, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: backgroundColor ?? Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
        child: Text(
          text,
          style: const TextStyle(color: Colors.blue, fontSize: 32.0),
        ),
      ),
    );
  }
}
