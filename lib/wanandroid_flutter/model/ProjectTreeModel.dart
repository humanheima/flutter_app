import 'dart:convert' show json;

class ProjectTreeModel {

  int? errorCode;
  String? errorMsg;
  List<ProjectTreeData>? data;

  ProjectTreeModel.fromParams({this.errorCode, this.errorMsg, this.data});

  factory ProjectTreeModel.fromJson(dynamic jsonStr) {
    if (jsonStr == null) return ProjectTreeModel.fromParams();
    final jsonRes = jsonStr is String ? json.decode(jsonStr) : jsonStr;
    return ProjectTreeModel.fromMap(jsonRes);
  }

  ProjectTreeModel.fromMap(dynamic jsonRes) {
    if (jsonRes == null) return;
    errorCode = jsonRes['errorCode'] as int?;
    errorMsg = jsonRes['errorMsg'] as String?;
    final list = jsonRes['data'] as List<dynamic>?;
    data = list?.map((dataItem) => dataItem == null ? null : ProjectTreeData.fromJson(dataItem)).whereType<ProjectTreeData>().toList();
  }

  @override
  String toString() {
    return '{"errorCode": $errorCode,"errorMsg": ${errorMsg != null? '${json.encode(errorMsg)}' : 'null'},"data": $data}';
  }
}

class ProjectTreeData {

  int? courseId;
  int? id;
  int? order;
  int? parentChapterId;
  int? visible;
  bool? userControlSetTop;
  String? name;
  List<dynamic>? children;

  ProjectTreeData.fromParams({this.courseId, this.id, this.order, this.parentChapterId, this.visible, this.userControlSetTop, this.name, this.children});

  ProjectTreeData.fromJson(dynamic jsonRes) {
    if (jsonRes == null) return;
    courseId = jsonRes['courseId'] as int?;
    id = jsonRes['id'] as int?;
    order = jsonRes['order'] as int?;
    parentChapterId = jsonRes['parentChapterId'] as int?;
    visible = jsonRes['visible'] as int?;
    userControlSetTop = jsonRes['userControlSetTop'] as bool?;
    name = jsonRes['name'] as String?;
    children = (jsonRes['children'] as List<dynamic>?)?.map((e) => e).toList();
  }

  @override
  String toString() {
    return '{"courseId": $courseId,"id": $id,"order": $order,"parentChapterId": $parentChapterId,"visible": $visible,"userControlSetTop": $userControlSetTop,"name": ${name != null? '${json.encode(name)}' : 'null'},"children": $children}';
  }
}
