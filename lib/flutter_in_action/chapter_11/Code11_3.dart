import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

///
/// Created by dumingwei on 2019-10-12.
/// Desc:
///
class DioTest extends StatefulWidget {
  @override
  State createState() => _DiotestState();
}

class _DiotestState extends State<DioTest> {
  Dio _dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('11.3 Http请求-Dio http库'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: FutureBuilder(
            future: _dio.get("https://api.github.com/orgs/flutterchina/repos"),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                Response response = snapshot.data;
                return ListView(
                  children: response.data
                      .map<Widget>((e) => ListTile(
                            title: Text(e['full_name']),
                          ))
                      .toList(),
                );
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
