import 'package:frontend/src/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group.g.dart';

@JsonSerializable()
class Group {
  String id, name, creator_id, created_at, savings;
  List<Member> members;

  Group({
    required this.id,
    required this.name,
    required this.creator_id,
    required this.savings,
    required this.created_at,
    required this.members,
  });

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  Map<String, dynamic> toJson() => _$GroupToJson(this);
}

@JsonSerializable()
class Member {
  String id, user_id, group_id, joined_at;
  User user;

  Member({
    required this.id,
    required this.user_id,
    required this.group_id,
    required this.joined_at,
    required this.user,
  });

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

  Map<String, dynamic> toJson() => _$MemberToJson(this);
}
