import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/forget_password/forget_password_screen.dart';
import 'package:bookia/features/auth/presentation/forget_password/otp_screen.dart';
import 'package:bookia/features/auth/presentation/forget_password/password_changed_screen.dart';
import 'package:bookia/features/auth/presentation/forget_password/reset_password_screen.dart';
import 'package:bookia/features/auth/presentation/login_register/pages/login_screen.dart';
import 'package:bookia/features/auth/presentation/login_register/pages/register_screen.dart';
import 'package:bookia/features/home/pages/home_screen.dart';
import 'package:bookia/features/main/main_app_screen.dart';
import 'package:bookia/features/splash/splash_screen.dart';
import 'package:bookia/features/welcome/welocme_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
 // routes config

  static final routes = GoRouter(
    routes: [
      GoRoute(path: Routes.splash, builder: (context, state) => const SplashScreen()),

      GoRoute(
        path: Routes.welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(path: Routes.login, builder: (context, state) => BlocProvider(
        create: (context) => AuthCubit(),
        child: LoginScreen())),
      GoRoute(path: Routes.register, builder: (context, state) => BlocProvider(
        create: (context) => AuthCubit(),
        child:RegisterScreen())),
     
      GoRoute(path: Routes.home, builder: (context, state) => HomeScreen()),
      GoRoute(path: Routes.main, builder: (context, state) => MainAppScreen()),
     
      GoRoute(
        path: Routes.forgetPass,
        builder: (context, state) => BlocProvider(
        create: (context) => AuthCubit(),
        child:ForgetPasswordScreen())),  
 GoRoute(
        path: Routes.otp,
        builder: (context, state){
       final String receivedEmail = state.extra as String;
       return BlocProvider(
        create: (context) => AuthCubit()..updateEmail(receivedEmail),
         child:OtpScreen());}),  

         GoRoute(
        path: Routes.resetPass,
        builder: (context, state){ 
           final String receivedcode = state.extra as String;
       return BlocProvider(
        create: (context) => AuthCubit()..sendCode(receivedcode),
        child:ResetPasswordScreen());}),      
    
     GoRoute(path: Routes.passwordChanged, builder: (context, state) => const PasswordChangedScreen()),

    
    
    ],
  );


}