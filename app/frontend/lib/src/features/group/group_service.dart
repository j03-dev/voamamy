import 'package:dio/dio.dart';
import 'package:frontend/src/models/group.dart';
import 'package:frontend/src/services/service.dart';

class GroupService extends Service {
  Future<Group> create(String? name) async {
    final token = await sharedPreference.getToken();
    final response = await dio.post(
      "$baseUrl/api/groups",
      data: {"name": name},
      options: Options(headers: {"authorization": "Bearer $token"}),
    );
    final data = response.data["groups"];
    return Group.fromJson(data);
  }

  Future<Group> my() async {
    final token = await sharedPreference.getToken();
    final response = await dio.get(
      "$baseUrl/api/groups/my",
      options: Options(headers: {"authorization": "Bearer $token"}),
    );
    final data = response.data["groups"];
    return Group.fromJson(data);
  }

  Future<Group> markAsContributed() async {
    final token = await sharedPreference.getToken();
    final response = await dio.post(
      "$baseUrl/api/groups/contributions",
      options: Options(headers: {"authorization": "Bearer $token"}),
    );
    final data = response.data["groups"];
    return Group.fromJson(data);
  }
}
