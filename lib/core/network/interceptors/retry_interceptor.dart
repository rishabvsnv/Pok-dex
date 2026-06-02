import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  final Dio dio;

  RetryInterceptor(this.dio);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final shouldRetry =
        err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.connectionTimeout;

    if (!shouldRetry) {
      return handler.next(err);
    }

    try {
      final response = await dio.fetch(err.requestOptions);

      return handler.resolve(response);
    } catch (_) {
      return handler.next(err);
    }
  }
}
