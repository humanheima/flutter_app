import 'package:json_annotation/json_annotation.dart';

part 'Person.g.dart';

@JsonSerializable()
class Person {
    Person();

    String name;
    num age;
    
    factory Person.fromJson(Map<String,dynamic> json) => _$PersonFromJson(json);
    Map<String, dynamic> toJson() => _$PersonToJson(this);
}
