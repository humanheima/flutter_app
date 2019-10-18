import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_app/models/SearchPage.dart';
part 'SearchPageList.g.dart';

@JsonSerializable()
class SearchPageList {
  SearchPageList();

  SearchPage data;
  num errorCode;
  String errorMsg;

  factory SearchPageList.fromJson(Map<String, dynamic> json) =>
      _$SearchPageListFromJson(json);
  Map<String, dynamic> toJson() => _$SearchPageListToJson(this);
}
