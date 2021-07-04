import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_app/models/SearchBean.dart';
part 'SearchPage.g.dart';

@JsonSerializable()
class SearchPage {
  SearchPage();

  num curPage;
  List<SearchBean> datas;
  num offset;
  bool over;
  num pageCount;
  num size;
  num total;

  factory SearchPage.fromJson(Map<String, dynamic> json) =>
      _$SearchPageFromJson(json);
  Map<String, dynamic> toJson() => _$SearchPageToJson(this);
}
