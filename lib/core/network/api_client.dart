import 'package:dio/dio.dart';
import 'package:pokedex/core/network/api_response.dart';
import 'package:pokedex/core/network/network_exceptions.dart';

class ApiClient {
  final Dio dio;

  ApiClient(this.dio);

  Future<ApiResponse<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(path, queryParameters: queryParameters);

      return ApiResponse.success(response.data);
    } on DioException catch (e) {
      return ApiResponse.failure(NetworkExceptions.fromDioException(e).message);
    }
  }

  Future<ApiResponse<dynamic>> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );

      return ApiResponse.success(response.data);
    } on DioException catch (e) {
      return ApiResponse.failure(NetworkExceptions.fromDioException(e).message);
    }
  }
}
