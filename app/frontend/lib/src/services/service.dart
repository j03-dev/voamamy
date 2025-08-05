import 'package:dio/dio.dart';
import 'package:frontend/src/core/shared_preference.dart';

abstract class Service {
  final dio = Dio();
  final baseUrl = "https://voamamy.onrender.com";
  final sharedPreference = SharedPreference();
}
