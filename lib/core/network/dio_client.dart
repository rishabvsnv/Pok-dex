import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/constants/api_constants.dart';
import 'package:pokedex/core/network/interceptors/logger_interceptor.dart';
import 'package:pokedex/core/network/interceptors/retry_interceptor.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      responseType: ResponseType.json,
      headers: {'Content-Type': 'application/json'},
    ),
  );

  dio.interceptors.addAll([LoggerInterceptor(), RetryInterceptor(dio)]);

  return dio;
});
