import 'package:dio/dio.dart';

abstract class Service {
  final dio = Dio();
  final baseUrl = "http://localhost:5555";
}
