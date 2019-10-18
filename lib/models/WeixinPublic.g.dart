// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WeixinPublic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeixinPublic _$WeixinPublicFromJson(Map<String, dynamic> json) {
  return WeixinPublic()
    ..courseId = json['courseId'] as num
    ..id = json['id'] as num
    ..name = json['name'] as String
    ..order = json['order'] as num
    ..parentChapterId = json['parentChapterId'] as num
    ..userControlSetTop = json['userControlSetTop'] as bool
    ..visible = json['visible'] as num;
}

Map<String, dynamic> _$WeixinPublicToJson(WeixinPublic instance) =>
    <String, dynamic>{
      'courseId': instance.courseId,
      'id': instance.id,
      'name': instance.name,
      'order': instance.order,
      'parentChapterId': instance.parentChapterId,
      'userControlSetTop': instance.userControlSetTop,
      'visible': instance.visible
    };
