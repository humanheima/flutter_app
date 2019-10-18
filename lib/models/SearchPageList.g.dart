// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SearchPageList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchPageList _$SearchPageListFromJson(Map<String, dynamic> json) {
  return SearchPageList()
    ..data = json['data'] == null
        ? null
        : SearchPage.fromJson(json['data'] as Map<String, dynamic>)
    ..errorCode = json['errorCode'] as num
    ..errorMsg = json['errorMsg'] as String;
}

Map<String, dynamic> _$SearchPageListToJson(SearchPageList instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg
    };
