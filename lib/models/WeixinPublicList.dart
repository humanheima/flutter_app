import 'package:flutter_app/models/WeixinPublic.dart';
import 'package:json_annotation/json_annotation.dart';

part 'WeixinPublicList.g.dart';

@JsonSerializable()
class WeixinPublicList {
  WeixinPublicList();

  num errorCode;
  String errorMsg;
  List<WeixinPublic> data;

  factory WeixinPublicList.fromJson(Map<String, dynamic> json) =>
      _$WeixinPublicListFromJson(json);

  Map<String, dynamic> toJson() => _$WeixinPublicListToJson(this);
}
