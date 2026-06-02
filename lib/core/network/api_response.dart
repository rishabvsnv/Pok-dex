class ApiResponse<T> {
  final T? data;
  final String? message;
  final bool success;

  const ApiResponse({this.data, this.message, required this.success});

  factory ApiResponse.success(T data) {
    return ApiResponse(data: data, success: true);
  }

  factory ApiResponse.failure(String message) {
    return ApiResponse(message: message, success: false);
  }
}
