import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/auth/data/auth_params.dart';
import 'package:bookia/features/auth/data/repositories/auth_repo.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitState());
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  final verifyCodeController = TextEditingController();

  String userEmail = '';
  String verifyCode = '';

  @override
  Future<void> close() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
    verifyCodeController.dispose();
    return super.close();
  }

  Future<void> login() async {
    emit(AuthLoadingState());
    try {
      var params = AuthParams.login(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      var data = await AuthRepo.login(params);
      if (data != null) {
        SharedPref.saveToken(data.data?.token);
        SharedPref.saveUsrInfo(data.data?.user);

        emit(AuthSuccessState());
      }
    } catch (error) {
      emit(AuthErrorState(error.toString()));
    }
  }

  Future<void> register() async {
    emit(AuthLoadingState());

    try {
      var params = AuthParams.register(
        name: usernameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
        passwordConfirmation: passwordConfirmationController.text,
      );
      var data = await AuthRepo.register(params);
      if (data != null) {
        emit(AuthSuccessState());
      }
    } catch (error) {
      emit(AuthErrorState(error.toString()));
    }
  }

  Future<void> forgetPassword() async {
    emit(AuthLoadingState());
    // for cubit testing "due server error""
    Future.delayed(const Duration(seconds: 3));
    emit(AuthSuccessState());

    /// uncomment this when server works

    // try {
    //   var param = AuthParams(
    //     email: emailController.text.trim());
    //   var data = await AuthRepo.sendForgetPasswordLink(param);
    //   if (data != null) {
    //     emit(AuthSuccessState());
    //   }
    // } catch (error) {
    //   emit(AuthErrorState(error.toString()));
    // }
  }

  void updateEmail(String email) {
    userEmail = email;
  }

  Future<void> checkOtpCode() async {
    emit(AuthLoadingState());

    // for cubit testing "due server error""
    Future.delayed(const Duration(seconds: 3));
    emit(AuthSuccessState());

    /// uncomment this when server works

    //   try{
    //     if(userEmail.isEmpty){
    //       emit(AuthErrorState( 'something went wrong'));
    //     }
    // var params=AuthParams.verify(
    // email:userEmail,
    // code: verifyCodeController.text.trim(),

    // );
    // var data=await AuthRepo.checkForgetPasswordCode(params);
    // if(data!=null){
    //   emit(AuthSuccessState());
    // }
    //   }catch(error){
    //     emit(AuthErrorState(error.toString()));
    //   }
  }

  void sendCode(String code) {
    verifyCode = code;
  }

  Future<void> resetPassword() async {
    emit(AuthLoadingState());

    // for cubit testing "due server error""
    Future.delayed(const Duration(seconds: 3));
    emit(AuthSuccessState());

    /// uncomment this when server works

    //   try{
    // var params=AuthParams.resetPassword(
    // code: verifyCode.trim(),
    // newPassword: passwordController.text.trim(),
    // newPasswordConfirmation: passwordConfirmationController.text.trim(),

    // );
    // var data=await AuthRepo.resetPassword(params);
    // if(data!=null){
    //   emit(AuthSuccessState());
    // }
    //   }catch(error){
    //     emit(AuthErrorState(error.toString()));
    //   }
  }

  Future<void> resendVerifyCode() async {
    emit(AuthLoadingState());
    try {
      var token = SharedPref.getToken();
      var data = await AuthRepo.resendVerifyLink(token);
      if (data != null) {
        emit(AuthSuccessState());
      }
    } catch (error) {
      emit(AuthErrorState(error.toString()));
    }
  }

  Future<void> verifyEmail() async {
    emit(AuthLoadingState());
    try {
      var token = SharedPref.getToken();
      var params = AuthParams.verify(code: verifyCodeController.text.trim());
      var data = await AuthRepo.verifyEMail(params, token);
      if (data != null) {
        emit(AuthSuccessState());
      }
    } catch (error) {
      emit(AuthErrorState(error.toString()));
    }
  }

  Future<void> logOut() async {
    emit(AuthLoadingState());
    try {
      var token = SharedPref.getToken();
      var data = await AuthRepo.logoutUsr(token);
      if (data != null) {
        emit(AuthSuccessState());
      }
    } catch (error) {
      emit(AuthErrorState(error.toString()));
    }
  }
}
