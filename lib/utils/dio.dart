import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  dio.options.connectTimeout = const Duration(milliseconds: 5000);
  dio.options.receiveTimeout = const Duration(milliseconds: 3000);
  dio.options.headers['Content-Type'] = 'application/json';
  dio.interceptors.add(LogInterceptor(responseBody: true));
  return dio;
});
