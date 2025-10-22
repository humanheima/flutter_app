import 'dart:convert' show json;

class SystemTreeModel {

  int? errorCode;
  String? errorMsg;
  List<SystemTreeData>? data;

  SystemTreeModel.fromParams({this.errorCode, this.errorMsg, this.data});

  /// Nullable parser: returns null if jsonStr is null
  static SystemTreeModel? parse(dynamic jsonStr) {
    if (jsonStr == null) return null;
    if (jsonStr is String) {
      return SystemTreeModel.fromJson(json.decode(jsonStr));
    }
    return SystemTreeModel.fromJson(jsonStr);
  }

  SystemTreeModel.fromJson(dynamic jsonRes) {
    errorCode = jsonRes['errorCode'];
    errorMsg = jsonRes['errorMsg'];
    if (jsonRes['data'] != null) {
      data = <SystemTreeData>[];
      for (var dataItem in jsonRes['data']) {
        data!.add(dataItem == null ? SystemTreeData.fromParams() : SystemTreeData.fromJson(dataItem));
      }
    }
  }

  @override
  String toString() {
    return '{"errorCode": $errorCode,"errorMsg": ${errorMsg != null ? '${json.encode(errorMsg)}' : 'null'},"data": $data}';
  }
}

class SystemTreeData {

  int? courseId;
  int? id;
  int? order;
  int? parentChapterId;
  int? visible;
  bool? userControlSetTop;
  String? name;
  List<SystemTreeChild>? children;

  SystemTreeData.fromParams({this.courseId, this.id, this.order, this.parentChapterId, this.visible, this.userControlSetTop, this.name, this.children});

  SystemTreeData.fromJson(dynamic jsonRes) {
    courseId = jsonRes['courseId'];
    id = jsonRes['id'];
    order = jsonRes['order'];
    parentChapterId = jsonRes['parentChapterId'];
    visible = jsonRes['visible'];
    userControlSetTop = jsonRes['userControlSetTop'];
    name = jsonRes['name'];
    if (jsonRes['children'] != null) {
      children = <SystemTreeChild>[];
      for (var childrenItem in jsonRes['children']) {
        children!.add(childrenItem == null ? SystemTreeChild.fromParams() : SystemTreeChild.fromJson(childrenItem));
      }
    }
  }

  @override
  String toString() {
    return '{"courseId": $courseId,"id": $id,"order": $order,"parentChapterId": $parentChapterId,"visible": $visible,"userControlSetTop": $userControlSetTop,"name": ${name != null ? '${json.encode(name)}' : 'null'},"children": $children}';
  }
}

class SystemTreeChild {

  int? courseId;
  int? id;
  int? order;
  int? parentChapterId;
  int? visible;
  bool? userControlSetTop;
  String? name;
  List<dynamic>? children;

  SystemTreeChild.fromParams({this.courseId, this.id, this.order, this.parentChapterId, this.visible, this.userControlSetTop, this.name, this.children});

  SystemTreeChild.fromJson(dynamic jsonRes) {
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
