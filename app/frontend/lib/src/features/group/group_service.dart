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

  Future<Group> markAsContributed(String? groupId) async {
    final token = await sharedPreference.getToken();
    final response = await dio.post(
      "$baseUrl/api/groups/$groupId/contributions",
      options: Options(headers: {"authorization": "Bearer $token"}),
    );
    final data = response.data["groups"];
    return Group.fromJson(data);
  }

  Future<Loan> requestLoan({String? amount, String? state}) async {
    final token = await sharedPreference.getToken();
    final response = await dio.post(
      "$baseUrl/api/groups/loans",
      data: {"amount": amount, "state": state},
      options: Options(headers: {"authorization": "Bearer $token"}),
    );
    final data = response.data["loans"];
    return Loan.fromJson(data);
  }
}
