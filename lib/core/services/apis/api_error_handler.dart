import 'package:dio/dio.dart';

void dioErrorHandler(DioException error) {
  if (error.type == DioExceptionType.badResponse) {
    final statusCode = error.response?.statusCode;

    // Server errors (500, 502, 503, 504, etc.)
    if (statusCode != null && statusCode >= 500) {
      throw Exception(
        "Our servers are temporarily busy. Please try again in a few moments.",
      );
    }

    // Validation or client errors (e.g. 422 Unprocessable Entity)
    if (statusCode == 422) {
      final data = error.response?.data;
      if (data != null && data['errors'] is Map) {
        final Map<String, dynamic> errorsMap = data['errors'];
        if (errorsMap.isNotEmpty) {
          throw Exception(errorsMap.values.first[0]);
        }
      }
      throw Exception(
        data?['message'] ?? "Invalid input. Please check your data.",
      );
    }
  }

  // Network connection timeouts or connectivity issues
  if (error.type == DioExceptionType.connectionError ||
      error.type == DioExceptionType.sendTimeout ||
      error.type == DioExceptionType.receiveTimeout ||
      error.type == DioExceptionType.connectionTimeout) {
    throw Exception("Please check your internet connection and try again.");
  }

  // Default fallback for any other errors
  throw Exception(
    error.response?.data?['message'] ??
        "Something went wrong. Please try again.",
  );
}
