import 'package:json_annotation/json_annotation.dart';

part 'WeixinPublic.g.dart';

@JsonSerializable()
class WeixinPublic {
    WeixinPublic();

    num courseId;
    num id;
    String name;
    num order;
    num parentChapterId;
    bool userControlSetTop;
    num visible;
    
    factory WeixinPublic.fromJson(Map<String,dynamic> json) => _$WeixinPublicFromJson(json);
    Map<String, dynamic> toJson() => _$WeixinPublicToJson(this);
}
