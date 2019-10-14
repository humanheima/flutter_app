import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

///
/// Created by dumingwei on 2019-10-14.
/// Desc:
///
class Code12_6_2 extends StatefulWidget {
  @override
  State createState() {
    return _Code12_6_2State();
  }
}

class _Code12_6_2State extends State<Code12_6_2> {
  static const MethodChannel _methodChannel =
      MethodChannel('samples.flutter.io/platform_view');

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Platform View'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
              child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Button tapped $_counter time${_counter == 1 ? '' : 's'}.',
                  style: const TextStyle(fontSize: 17.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0, left: 15.0),
                  child: RaisedButton(
                      child: Platform.isIOS
                          ? const Text('Continue in iOS view')
                          : const Text('Continue in Android view'),
                      onPressed: () {
                        _launchPlatformCount();
                      }),
                )
              ],
            ),
          )),
          Container(
            padding: const EdgeInsets.only(bottom: 15.0, left: 5.0),
            child: Row(
              children: <Widget>[
                Image.asset(
                  'images/flutter-mark-square-64.png',
                  scale: 1.5,
                ),
                const Text(
                  'Flutter',
                  style: TextStyle(fontSize: 30.0),
                )
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increament',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _launchPlatformCount() async {
    final int platformCounter =
        await _methodChannel.invokeMethod('switchView', _counter);
    setState(() {
      _counter = platformCounter;
    });
  }
}
