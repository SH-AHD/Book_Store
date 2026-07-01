import 'package:bookia/core/services/apis/app_exception.dart';
import 'package:dio/dio.dart';

void dioErrorHandler(DioException error) {
  if (error.type == DioExceptionType.badResponse) {
    final statusCode = error.response?.statusCode;

    // Server errors (500, 502, 503, 504, etc.)
    if (statusCode != null && statusCode >= 500) {
      throw AppException(
        "Our servers are temporarily busy. Please try again in a few moments.",
      );
    }

    // Validation or client errors (e.g. 422 Unprocessable Entity)
    if (statusCode == 422) {
      final data = error.response?.data;
      if (data != null && data['errors'] is Map) {
        final Map<String, dynamic> errorsMap = data['errors'];
        if (errorsMap.isNotEmpty) {
          throw AppException(errorsMap.values.first[0]);
        }
      }
      throw AppException(
        data?['message'] ?? "Invalid input. Please check your data.",
      );
    }

    // Other client errors (401, 403, 404, etc.)
    final message = error.response?.data?['message'];
    if (message != null && message is String && message.isNotEmpty) {
      throw AppException(message);
    }
  }

  // Network connection timeouts or connectivity issues
  if (error.type == DioExceptionType.connectionError ||
      error.type == DioExceptionType.sendTimeout ||
      error.type == DioExceptionType.receiveTimeout ||
      error.type == DioExceptionType.connectionTimeout) {
    throw AppException("Please check your internet connection and try again.");
  }

  // Default fallback for any other errors
  throw AppException(
    error.response?.data?['message'] ??
        "Something went wrong. Please try again.",
  );
}
