import 'package:frontend/src/models/user.dart';
import 'package:frontend/src/services/service.dart';

class AuthService extends Service {
  Future<User> register(
    String? phoneNumber,
    String? fullName,
    String? password,
  ) async {
    final response = await dio.post(
      "$baseUrl/api/auth/register",
      data: {
        "phone_number": phoneNumber,
        "full_name": fullName,
        "password": password,
      },
    );
    final data = response.data["users"];
    return User.fromJson(data);
  }

  Future<void> login(String? phoneNumber, String? password) async {
    final response = await dio.post(
      "$baseUrl/api/auth/login",
      data: {"phone_number": phoneNumber, "password": password},
    );
    final token = response.data["token"];
    await sharedPreference.saveToken(token);
  }
}
