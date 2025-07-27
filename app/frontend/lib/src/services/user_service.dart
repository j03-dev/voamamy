import 'package:dio/dio.dart';
import 'package:frontend/src/models/user.dart';
import 'package:frontend/src/services/service.dart';

class UserService extends Service {
  Future<User> me() async {
    final token = await sharedPreference.getToken();
    final response = await dio.get(
      "$baseUrl/api/users/me",
      options: Options(headers: {"authorization": "Bearer $token"}),
    );
    final data = response.data["users"];
    return User.fromJson(data);
  }

  Future<User> retrieve(String userId) async {
    final token = await sharedPreference.getToken();
    final response = await dio.get(
      "$baseUrl/api/users/$userId",
      options: Options(headers: {"authorization": "Bearer $token"}),
    );
    final data = response.data["users"];
    return User.fromJson(data);
  }

  Future<User> update(
    String? userId,
    String? fullName,
    String? phoneNumber,
  ) async {
    final token = await sharedPreference.getToken();
    final response = await dio.put(
      "$baseUrl/api/users/$userId",
      data: {"phone_number": phoneNumber, "full_name": fullName},
      options: Options(headers: {"authorization": "Bearer $token"}),
    );
    final data = response.data["users"];
    return User.fromJson(data);
  }
}
