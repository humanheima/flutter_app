import 'package:flutter/material.dart';
import 'webview_real_page_demo.dart';

void main() {
  runApp(const RealWebPageTestApp());
}

class RealWebPageTestApp extends StatelessWidget {
  const RealWebPageTestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Real WebPage Demo Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const WebViewRealPageDemo(),
      debugShowCheckedModeBanner: false,
    );
  }
}
