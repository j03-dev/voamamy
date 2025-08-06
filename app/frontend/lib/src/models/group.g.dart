// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Group _$GroupFromJson(Map<String, dynamic> json) => Group(
  id: json['id'] as String,
  name: json['name'] as String,
  creator_id: json['creator_id'] as String,
  savings: (json['savings'] as num).toDouble(),
  created_at: json['created_at'] as String,
  members:
      (json['members'] as List<dynamic>)
          .map((e) => Member.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'creator_id': instance.creator_id,
  'created_at': instance.created_at,
  'savings': instance.savings,
  'members': instance.members,
};

Member _$MemberFromJson(Map<String, dynamic> json) => Member(
  id: json['id'] as String,
  user_id: json['user_id'] as String,
  group_id: json['group_id'] as String,
  joined_at: json['joined_at'] as String,
  user: User.fromJson(json['user'] as Map<String, dynamic>),
  has_contributed_this_week: json['has_contributed_this_week'] as bool,
);

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.user_id,
  'group_id': instance.group_id,
  'joined_at': instance.joined_at,
  'has_contributed_this_week': instance.has_contributed_this_week,
  'user': instance.user,
};

Loan _$LoanFromJson(Map<String, dynamic> json) => Loan(
  id: json['id'] as String,
  member_id: json['member_id'] as String,
  group_id: json['group_id'] as String,
  amount: json['amount'] as String,
  interest: json['interest'] as String,
  at: json['at'] as String,
  state: json['state'] as String,
  member: Member.fromJson(json['member'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LoanToJson(Loan instance) => <String, dynamic>{
  'id': instance.id,
  'member_id': instance.member_id,
  'group_id': instance.group_id,
  'amount': instance.amount,
  'interest': instance.interest,
  'at': instance.at,
  'state': instance.state,
  'member': instance.member,
};
