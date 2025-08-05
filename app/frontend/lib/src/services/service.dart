import 'package:dio/dio.dart';
import 'package:frontend/src/core/shared_preference.dart';

abstract class Service {
  final dio = Dio();
  final baseUrl = "http://172.19.63.112:5555";
  final sharedPreference = SharedPreference();
}
