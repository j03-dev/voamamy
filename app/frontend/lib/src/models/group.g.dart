// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Group _$GroupFromJson(Map<String, dynamic> json) => Group(
  id: json['id'] as String,
  name: json['name'] as String,
  creator_id: json['creator_id'] as String,
  savings: json['savings'] as String,
  created_at: json['created_at'] as String,
);

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'creator_id': instance.creator_id,
  'created_at': instance.created_at,
  'savings': instance.savings,
};
