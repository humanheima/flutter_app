import 'package:flutter/material.dart';

///
/// Created by dumingwei on 2019-10-09.
/// Desc: 异步UI更新（FutureBuilder、StreamBuilder）
///
class Code7_5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('7.5 异步UI更新（FutureBuilder、StreamBuilder）'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<String>(
                future: mockNetworkData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // 请求已结束
                    if (snapshot.hasError) {
                      // 请求失败，显示错误
                      return Text("Error: ${snapshot.error}");
                    } else {
                      // 请求成功，显示数据
                      return Text("Contents: ${snapshot.data}");
                    }
                  } else {
                    // 请求未结束，显示loading
                    return CircularProgressIndicator();
                  }
                }),
            Container(
              height: 20,
              width: 200,
              decoration: BoxDecoration(color: Colors.greenAccent),
            ),
            StreamBuilder<int>(
                stream: counter(),
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Text('没有Stream');
                    case ConnectionState.waiting:
                      return Text('等待数据...');
                    case ConnectionState.active:
                      return Text('active: ${snapshot.data}');
                    case ConnectionState.done:
                      return Text('Stream已关闭');
                  }
                  return null;
                }),
          ],
        ),
      ),
    );
  }
}

Future<String> mockNetworkData() async {
  return Future.delayed(Duration(seconds: 2), () => '我是从互联网上获取的数据');
}

Stream<int> counter() {
  return Stream.periodic(Duration(seconds: 1), (i) {
    return i;
  }).take(10);
}
