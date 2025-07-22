import 'package:frontend/src/models/user.dart';
import 'package:frontend/src/services/service.dart';

class AuthService extends Service {
  Future<User> register(
    String? phone_number,
    String? full_name,
    String? password,
  ) async {
    final response = await dio.post(
      "$baseUrl/api/auth/register",
      data: {
        "phone_number": phone_number,
        "full_name": full_name,
        "password": password,
      },
    );
    final data = response.data["users"];
    return User.fromJson(data);
  }

  Future<User> login(String? phone_number, String? password) async {
    final response = await dio.post(
      "$baseUrl/api/auth/login",
      data: {"phone_number": phone_number, "password": password},
    );
    final data = response.data["users"];
    return User.fromJson(data);
  }
}
