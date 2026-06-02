import 'package:dio/dio.dart';

class NetworkExceptions implements Exception {
  final String message;

  const NetworkExceptions(this.message);

  factory NetworkExceptions.fromDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return const NetworkExceptions('Connection timeout');

      case DioExceptionType.sendTimeout:
        return const NetworkExceptions('Send timeout');

      case DioExceptionType.receiveTimeout:
        return const NetworkExceptions('Receive timeout');

      case DioExceptionType.badCertificate:
        return const NetworkExceptions('Bad certificate');

      case DioExceptionType.badResponse:
        return NetworkExceptions(_handleStatusCode(error.response?.statusCode));

      case DioExceptionType.cancel:
        return const NetworkExceptions('Request cancelled');

      case DioExceptionType.connectionError:
        return const NetworkExceptions('No internet connection');

      case DioExceptionType.unknown:
        return const NetworkExceptions('Unexpected error occurred');
    }
  }

  static String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request';

      case 401:
        return 'Unauthorized';

      case 403:
        return 'Forbidden';

      case 404:
        return 'Resource not found';

      case 500:
        return 'Internal server error';

      default:
        return 'Something went wrong';
    }
  }

  @override
  String toString() => message;
}
