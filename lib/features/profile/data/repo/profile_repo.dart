import 'package:bookia/core/services/apis/api_error_handler.dart';
import 'package:bookia/core/services/apis/dio.dart';
import 'package:bookia/core/services/apis/endpoints.dart';
import 'package:bookia/features/auth/data/models/auth_response/user.dart';
import 'package:dio/dio.dart';

class ProfileRepo {
  static Future<User?> updateProfile({
    required String name,
    required String address,
    required String city,
    required String phone,
    String? imagePath,
  }) async {
    try {
      Map<String, dynamic> dataMap = {
        'name': name,
        'address': address,
        'city': city,
        'phone': phone,
      };
      if (imagePath != null && imagePath.isNotEmpty) {
        dataMap['image'] = await MultipartFile.fromFile(
          imagePath,
          filename: imagePath.split('/').last,
        );
      }

      FormData formData = FormData.fromMap(dataMap);

      var response = await DioProvider.post(
        endpoint: EndPoints.updateProfile,
        data: formData,
      );
      if (response.statusCode == 200) {
        final data = response.data['data'] as Map<String, dynamic>;
        return User.fromJson(data);
      }
    } on DioException catch (e) {
      dioErrorHandler(e);
    }
    return null;
  }

  static Future<User?> updatePassword({
    required String current_password,
    required String new_password,
    required String new_password_confirmation,
  }) async {
    try {
      var response = await DioProvider.post(
        endpoint: EndPoints.updatePasswordProfile,
        data: {
          "current_password": current_password,
          "new_password": new_password,
          "new_password_confirmation": new_password_confirmation,
        },
      );
      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      }
    } on DioException catch (e) {
      dioErrorHandler(e);
    }
    return null;
  }

  static Future<bool> deleteAccount({required String currentPassword}) async {
    try {
      var response = await DioProvider.post(
        endpoint: EndPoints.deleteProfile,
        data: {'current_password': currentPassword},
      );
      if (response.statusCode == 200) {
        return true;
      }
    } on DioException catch (e) {
      dioErrorHandler(e);
    }
    return false;
  }
}
