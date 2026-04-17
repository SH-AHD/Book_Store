import 'package:dio/dio.dart';

void dioErrorHandler(DioException error) {

  if (error.type == DioExceptionType.badResponse) {
    if (error.response?.statusCode == 422) {
      final data = error.response?.data;
      if (data != null && data['errors'] is Map) {
        final Map<String, dynamic> errorsMap = data['errors'];
        if (errorsMap.isNotEmpty) {
          throw errorsMap.values.first[0];
        }
      }
      throw data?['message'] ?? "Invalid credentials";
    }
  }

  if (error.type == DioExceptionType.connectionError || 
      error.type == DioExceptionType.sendTimeout ||
      error.type == DioExceptionType.receiveTimeout ||
      error.type == DioExceptionType.connectionTimeout) {
    
    throw "Please check your internet connection and try again";
  }

  throw error.response?.data['message'] ?? "Something went wrong. Please try again";
}