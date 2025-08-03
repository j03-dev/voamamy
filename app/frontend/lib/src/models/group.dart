import 'package:json_annotation/json_annotation.dart';

part 'group.g.dart';

// TODO: Add members on Group Model

@JsonSerializable()
class Group {
  String id, name, creator_id, created_at, savings;
  Group({
    required this.id,
    required this.name,
    required this.creator_id,
    required this.savings,
    required this.created_at,
  });

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  Map<String, dynamic> toJson() => _$GroupToJson(this);
}
