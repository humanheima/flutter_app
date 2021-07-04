// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WeixinPublicList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeixinPublicList _$WeixinPublicListFromJson(Map<String, dynamic> json) {
  return WeixinPublicList()
    ..errorCode = json['errorCode'] as num
    ..errorMsg = json['errorMsg'] as String
    ..data = (json['data'] as List)
        ?.map((e) =>
            e == null ? null : WeixinPublic.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$WeixinPublicListToJson(WeixinPublicList instance) =>
    <String, dynamic>{
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
      'data': instance.data
    };
