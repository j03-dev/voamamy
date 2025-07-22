// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: json['id'] as String,
  phone_number: json['phone_number'] as String,
  full_name: json['full_name'] as String,
  created_at: json['created_at'] as String,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'phone_number': instance.phone_number,
  'full_name': instance.full_name,
  'created_at': instance.created_at,
};
