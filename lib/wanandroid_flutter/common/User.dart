///
/// Created by dumingwei on 2019/4/13.
/// Desc:
///

class User {
  static final User singleton = User._internal();

  User._internal();

  factory User() {
    return singleton;
  }

  List<String> cookie;
  String userName;
}
