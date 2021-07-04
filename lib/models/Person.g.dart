// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) {
  return Person()
    ..name = json['name'] as String
    ..age = json['age'] as num;
}

Map<String, dynamic> _$PersonToJson(Person instance) =>
    <String, dynamic>{'name': instance.name, 'age': instance.age};
