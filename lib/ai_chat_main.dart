import 'package:flutter/material.dart';
import 'widget/AIChatDemo.dart';

void main() => runApp(AIChatApp());

class AIChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI聊天演示',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AIChatDemo(),
      debugShowCheckedModeBanner: false,
    );
  }
}
