import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/helpers/app_validator.dart';
import 'package:bookia/core/helpers/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/app_text_field.dart';
import 'package:bookia/core/widgets/body_view.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:bookia/features/auth/presentation/login_register/widgets/social_login.dart';
import 'package:bookia/features/auth/presentation/widgets/auth_footer.dart';
import 'package:bookia/features/auth/presentation/widgets/auth_listener_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        authListener(
          context: context,
          state: state,
          navigationMethod: pushPage,
          routName: Routes.main,
        );
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: GestureDetector(
            onTap: () {
              popPage(context);
            },
            child: SvgPic(path: AppAssets.backSvg),
          ),
        ),
        body: _loginBody(context),
        bottomNavigationBar: AuthFooter(
          ques: "Don’t have an account? ",
          actionsen: "Register Now",
          onTap: () {
            pushReplacementPage(context, Routes.register);
          },
        ),
      ),
    );
  }

  SingleChildScrollView _loginBody(BuildContext context) {
    AuthCubit cubit = context.read<AuthCubit>();
    return SingleChildScrollView(
      child: BodyView(
        child: Form(
          key: cubit.formKey,
          child: Column(
            children: [
              Text(
                "Welcome back! Glad to see you, Again!",
                style: TextStyles.font30,
              ),
              Gap(32),
              AppTextField(
                controller: cubit.emailController,
                hintText: "Enter your email",
                validator: AppValidators.validateEmail,
              ),
              Gap(15),
              AppTextField(
                controller: cubit.passwordController,
                hintText: "Enter your password",
                validator: AppValidators.validatePassword,
                isPass: true,
              ),
              Gap(13),
              Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () {
                    pushPage(context, Routes.forgetPass);
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyles.font14.copyWith(
                      color: AppColors.darkGrayColor,
                    ),
                  ),
                ),
              ),
              Gap(30),
              MainButton(
                text: "Login",
                onPressed: () {
                  if (cubit.formKey.currentState!.validate()) {
                    cubit.login();
                  }
                },
              ),
              Gap(34),
              SocialLogin(),
            ],
          ),
        ),
      ),
    );
  }
}
