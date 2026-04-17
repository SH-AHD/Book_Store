 import 'package:dio/dio.dart';

void dioErrorHandler(DioException error) {
  if (error.response?.statusCode == 422) {
    final data = error.response?.data;
    
    // Check if 'errors' exists and is a Map
    if (data != null && data['errors'] is Map) {
      final Map<String, dynamic> errorsMap = data['errors'];
      if (errorsMap.isNotEmpty) {
        throw errorsMap.values.first[0];
      }
    }
    
    // Fallback to the 'message' field provided in your log
    throw data?['message'] ?? "Invalid credentials";
  }

  if (error.type == DioExceptionType.connectionTimeout) {
    throw "Make sure you have a Wi-Fi connection";
  }

  throw error.response?.data['message'] ?? "Something went wrong. Please try again";
}