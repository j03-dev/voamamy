import 'package:frontend/src/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group.g.dart';

@JsonSerializable()
class Group {
  String id, name, creator_id, created_at;
  double savings;
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
  bool has_contributed_this_week;

  User user;

  Member({
    required this.id,
    required this.user_id,
    required this.group_id,
    required this.joined_at,
    required this.user,
    required this.has_contributed_this_week,
  });

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

  Map<String, dynamic> toJson() => _$MemberToJson(this);
}

@JsonSerializable()
class Loan {
  String id, member_id, group_id, amount, interest, at, state;
  Member member;

  Loan({
    required this.id,
    required this.member_id,
    required this.group_id,
    required this.amount,
    required this.interest,
    required this.at,
    required this.state,
    required this.member,
  });

  factory Loan.fromJson(Map<String, dynamic> json) => _$LoanFromJson(json);

  Map<String, dynamic> toJson() => _$LoanToJson(this);
}
