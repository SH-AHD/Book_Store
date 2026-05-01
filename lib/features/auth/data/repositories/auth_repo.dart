import 'package:bookia/core/services/apis/api_error_handler.dart';
import 'package:bookia/core/services/apis/endpoints.dart';
import 'package:bookia/core/services/apis/dio.dart';
import 'package:bookia/features/auth/data/auth_params.dart';
import 'package:bookia/features/auth/data/models/auth_response/auth_response.dart';
import 'package:dio/dio.dart';

class AuthRepo {
  static Future<AuthResponse?> login(AuthParams params) async {
    try {
      var response = await DioProvider.post(
        endpoint: EndPoints.login,
        data: params.toJson(),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return AuthResponse.fromJson(response.data);
      }
      // else {
      //   throw response.data['message'] ??
      //       "Something went wrong. Try again letter";
      //   // return null;
      // }
    } on DioException catch (error) {
      dioErrorHandler(error);
    }
    return null;
  }

  static Future<AuthResponse?> register(AuthParams params) async {
    try {
      var response = await DioProvider.post(
        endpoint: EndPoints.register,
        data: params.toJson(),
      );

      return AuthResponse.fromJson(response.data);
    } on DioException catch (error) {
      dioErrorHandler(error);
    }
    return null;
  }

  static Future<AuthResponse?> sendForgetPasswordLink(AuthParams params) async {
    try {
      var response = await DioProvider.post(
        endpoint: EndPoints.forgetPassword,
        data: params.toJson(),
      );

      return AuthResponse.fromJson(response.data);
    } on DioException catch (error) {
      dioErrorHandler(error);
    }
    return null;
  }

  static Future<AuthResponse?> checkForgetPasswordCode(
    AuthParams params,
  ) async {
    try {
      var response = await DioProvider.post(
        endpoint: EndPoints.checkForgetPassword,
        data: params.toJson(),
      );
      return AuthResponse.fromJson(response.data);
    } on DioException catch (error) {
      dioErrorHandler(error);
    }

    return null;
  }

  static Future<AuthResponse?> resetPassword(AuthParams params) async {
    try {
      var response = await DioProvider.post(
        endpoint: EndPoints.resetPassword,
        data: params.toJson(),
      );
      return AuthResponse.fromJson(response.data);
    } on DioException catch (error) {
      dioErrorHandler(error);
    }

    return null;
  }

  static Future<AuthResponse?> resendVerifyLink(String token) async {
    try {
      var response = await DioProvider.post(
        endpoint: EndPoints.resendVerifyCode,
        headers: {'Authorization': 'Bearer $token'},
      );
      return AuthResponse.fromJson(response.data);
    } on DioException catch (error) {
      dioErrorHandler(error);
    }

    return null;
  }

  static Future<AuthResponse?> verifyEMail(
    AuthParams params,
    String token,
  ) async {
    try {
      var response = await DioProvider.post(
        endpoint: EndPoints.verifyEmail,
        data: params.toJson(),
        headers: {'Authorization': 'Bearer $token'},
      );
      return AuthResponse.fromJson(response.data);
    } on DioException catch (error) {
      dioErrorHandler(error);
    }

    return null;
  }

  static Future<AuthResponse?> logoutUsr(String token) async {
    try {
      var response = await DioProvider.post(
        endpoint: EndPoints.logout,
        headers: {'Authorization': 'Bearer $token'},
      );
      return AuthResponse.fromJson(response.data);
    } on DioException catch (error) {
      dioErrorHandler(error);
    }

    return null;
  }
}
