import 'package:dio/dio.dart';

class ApiErrorHandler {

 static void dioErrorHandler(DioException error){
     if (error.response?.statusCode == 422) {
      final Map<String, dynamic> errorsMap = error.response?.data['errors'];
      
      final firstError = errorsMap.values.first[0]; 
      
      throw firstError; 
    }

    if (error.type == DioExceptionType.connectionTimeout) {
      throw "Make sure it has a Wi-Fi connection";
    }

    throw error.response?.data['message'] ?? "Something went wrong. Please try again";
 
  }
}