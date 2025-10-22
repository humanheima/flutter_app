import 'dart:convert' show json;

///import 'dart:convert' show json;
///表示只引入json.dart
class WxArticleTitleModel {
  int? errorCode;
  String? errorMsg;
  List<WxArticleTitleData>? data;

  WxArticleTitleModel.fromParams({this.errorCode, this.errorMsg, this.data});

  static WxArticleTitleModel? parse(dynamic jsonStr) {
    if (jsonStr == null) return null;
    if (jsonStr is String) {
      return WxArticleTitleModel.fromJson(json.decode(jsonStr));
    }
    return WxArticleTitleModel.fromJson(jsonStr);
  }

  WxArticleTitleModel.fromJson(dynamic jsonRes) {
    errorCode = jsonRes['errorCode'];
    errorMsg = jsonRes['errorMsg'];
    if (jsonRes['data'] != null) {
      data = <WxArticleTitleData>[];
      for (var dataItem in jsonRes['data']) {
        data!.add(dataItem == null ? WxArticleTitleData.fromParams() : WxArticleTitleData.fromJson(dataItem));
      }
    }
  }

  @override
  String toString() {
    return '{"errorCode": $errorCode,"errorMsg": ${errorMsg != null ? '${json.encode(errorMsg)}' : 'null'},"data": $data}';
  }
}

class WxArticleTitleData {
  int? courseId;
  int? id;
  int? order;
  int? parentChapterId;
  int? visible;
  bool? userControlSetTop;
  String? name;
  List<dynamic>? children;

  WxArticleTitleData.fromParams({this.courseId, this.id, this.order, this.parentChapterId, this.visible, this.userControlSetTop, this.name, this.children});

  WxArticleTitleData.fromJson(dynamic jsonRes) {
    courseId = jsonRes['courseId'];
    id = jsonRes['id'];
    order = jsonRes['order'];
    parentChapterId = jsonRes['parentChapterId'];
    visible = jsonRes['visible'];
    userControlSetTop = jsonRes['userControlSetTop'];
    name = jsonRes['name'];
    if (jsonRes['children'] != null) {
      children = <dynamic>[];
      for (var childrenItem in jsonRes['children']) {
        children!.add(childrenItem);
      }
    }
  }

  @override
  String toString() {
    return '{"courseId": $courseId,"id": $id,"order": $order,"parentChapterId": $parentChapterId,"visible": $visible,"userControlSetTop": $userControlSetTop,"name": ${name != null ? '${json.encode(name)}' : 'null'},"children": $children}';
  }
}
