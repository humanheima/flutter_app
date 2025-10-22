import 'dart:convert';

class BannerModel {
  int? errorCode;
  String? errorMsg;
  List<BannerData>? data;

  BannerModel({this.errorCode, this.errorMsg, this.data});

  factory BannerModel.fromJson(dynamic jsonRes) {
    if (jsonRes == null) return BannerModel();
    final Map<String, dynamic> map = jsonRes is String ? jsonDecode(jsonRes) : Map<String, dynamic>.from(jsonRes as Map);
    return BannerModel(
      errorCode: map['errorCode'] as int?,
      errorMsg: map['errorMsg'] as String?,
      data: (map['data'] as List?)
          ?.where((e) => e != null)
          .map((e) => BannerData.fromJson(e))
          .toList(),
    );
  }

  @override
  String toString() {
    return jsonEncode({
      'errorCode': errorCode,
      'errorMsg': errorMsg,
      'data': data,
    });
  }
}

class BannerData {
  int? id;
  int? isVisible;
  int? order;
  int? type;
  String? desc;
  String? imagePath;
  String? title;
  String? url;

  BannerData({this.id, this.isVisible, this.order, this.type, this.desc, this.imagePath, this.title, this.url});

  factory BannerData.fromJson(dynamic jsonRes) {
    if (jsonRes == null) return BannerData();
    final Map<String, dynamic> map = jsonRes is String ? jsonDecode(jsonRes) : Map<String, dynamic>.from(jsonRes as Map);
    return BannerData(
      id: map['id'] as int?,
      isVisible: map['isVisible'] as int?,
      order: map['order'] as int?,
      type: map['type'] as int?,
      desc: map['desc'] as String?,
      imagePath: map['imagePath'] as String?,
      title: map['title'] as String?,
      url: map['url'] as String?,
    );
  }

  @override
  String toString() {
    return jsonEncode({
      'id': id,
      'isVisible': isVisible,
      'order': order,
      'type': type,
      'desc': desc,
      'imagePath': imagePath,
      'title': title,
      'url': url,
    });
  }
}
