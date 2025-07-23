import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static const String key = "auth_token";
  final sharedPreferences = SharedPreferences.getInstance();

  Future<void> saveToken(String token) async {
    await (await sharedPreferences).setString(key, token);
  }

  Future<String?> getToken() async {
    return await (await sharedPreferences).getString(key);
  }

  Future<void> delToken() async {
    await (await sharedPreferences).remove(key);
  }
}
