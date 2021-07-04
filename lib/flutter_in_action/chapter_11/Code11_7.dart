import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/models/Person.dart';

///
/// Created by dumingwei on 2019-10-12.
/// Desc:
///
class Code11_7 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('11.7 Json转Dart Model类'),
      ),
      body: ListView(
        children: <Widget>[
          RaisedButton(
              child: Text('简单解析json字符串'),
              onPressed: () {
                parse();
              }),
          RaisedButton(
              child: Text('json映射对象'),
              onPressed: () {
                jsonToModel();
              }),
          RaisedButton(
              child: Text('测试json_model生成的实体类'),
              onPressed: () {
                testJsonModel();
              }),
        ],
      ),
    );
  }

  void parse() {
    //一个JSON格式的用户列表字符串
    String jsonStr = '[{"name":"Jack"},{"name":"Rose"}]';
    //将JSON字符串转为Dart对象(此处是List)
    List items = json.decode(jsonStr);
    //输出第一个用户的姓名
    print(items[0]['name']);
  }

  void jsonToModel() {
    //一个JSON格式的用户列表字符串
    String jsonStr =
        '{"name":"Jack", "email":"json.example.com","numbers":"[1,2,3,4]"}';
    Map userMap = json.decode(jsonStr);
    var user = new User.fromJson(userMap);
    //输出第一个用户的姓名
    print(user.numbers);
  }

  void testJsonModel() {
    String personStr = '{"name":"Jack","age":10}';
    Map personMap = json.decode(personStr);
    Person person = new Person.fromJson(personMap);
    print(person.name);
  }
}

class User {
  final String name;
  final String email;
  final List<int> numbers;

  User(this.name, this.email, this.numbers);

  User.fromJson(Map<String, dynamic> jsonStr)
      : name = jsonStr['name'],
        email = jsonStr['email'],
        numbers = json.decode(jsonStr['numbers']).cast<int>();

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'email': email,
        'numbers': json.encode(numbers),
      };
}
