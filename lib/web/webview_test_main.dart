import 'package:flutter/material.dart';
import 'web_demos.dart';

void main() {
  runApp(const WebViewTestApp());
}

class WebViewTestApp extends StatelessWidget {
  const WebViewTestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebView Demo Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WebDemoEntryPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
