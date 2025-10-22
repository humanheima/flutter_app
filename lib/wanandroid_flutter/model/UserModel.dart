import 'dart:convert' show json;

class UserModel {

  int? errorCode;
  String? errorMsg;
  UserData? data;

  UserModel.fromParams({this.errorCode, this.errorMsg, this.data});

  /// Nullable parser
  static UserModel? parse(dynamic jsonStr) {
    if (jsonStr == null) return null;
    if (jsonStr is String) {
      return UserModel.fromJson(json.decode(jsonStr));
    }
    return UserModel.fromJson(jsonStr);
  }

  UserModel.fromJson(dynamic jsonRes) {
    errorCode = jsonRes['errorCode'];
    errorMsg = jsonRes['errorMsg'];
    data = jsonRes['data'] != null ? UserData.fromJson(jsonRes['data']) : null;
  }

  @override
  String toString() {
    return '{"errorCode": $errorCode,"errorMsg": ${errorMsg != null ? '${json.encode(errorMsg)}' : 'null'},"data": $data}';
  }
}

class UserData {

  int? id;
  int? type;
  String? email;
  String? icon;
  String? password;
  String? token;
  String? username;
  List<dynamic>? chapterTops;
  List<int>? collectIds;

  UserData.fromParams({this.id, this.type, this.email, this.icon, this.password, this.token, this.username, this.chapterTops, this.collectIds});
  
  UserData.fromJson(dynamic jsonRes) {
    id = jsonRes['id'];
    type = jsonRes['type'];
    email = jsonRes['email'];
    icon = jsonRes['icon'];
    password = jsonRes['password'];
    token = jsonRes['token'];
    username = jsonRes['username'];
    if (jsonRes['chapterTops'] != null) {
      chapterTops = <dynamic>[];
      for (var chapterTopsItem in jsonRes['chapterTops']) {
        chapterTops!.add(chapterTopsItem);
      }
    }

    if (jsonRes['collectIds'] != null) {
      collectIds = <int>[];
      for (var collectIdsItem in jsonRes['collectIds']) {
        collectIds!.add(collectIdsItem);
      }
    }
  }

  @override
  String toString() {
    return '{"id": $id,"type": $type,"email": ${email != null ? '${json.encode(email)}' : 'null'},"icon": ${icon != null ? '${json.encode(icon)}' : 'null'},"password": ${password != null ? '${json.encode(password)}' : 'null'},"token": ${token != null ? '${json.encode(token)}' : 'null'},"username": ${username != null ? '${json.encode(username)}' : 'null'},"chapterTops": $chapterTops,"collectIds": $collectIds}';
  }
}
