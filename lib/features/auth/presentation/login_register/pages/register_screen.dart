import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/helpers/app_validator.dart';
import 'package:bookia/core/helpers/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/app_text_field.dart';
import 'package:bookia/core/widgets/body_view.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:bookia/features/auth/presentation/widgets/auth_footer.dart';
import 'package:bookia/features/auth/presentation/widgets/auth_listener_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
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
        body: _registerBody(context),
        bottomNavigationBar: AuthFooter(
          ques: "Already have an account? ",
          actionsen: "Login Now",
          onTap: () {
            pushReplacementPage(context, Routes.login);
          },
        ),
      ),
    );
  }

  SingleChildScrollView _registerBody(BuildContext context) {
    AuthCubit cubit = context.read<AuthCubit>();
    return SingleChildScrollView(
      child: BodyView(
        child: Form(
          key: cubit.formKey,
          autovalidateMode: AutovalidateMode.onUnfocus,
          child: Column(
            children: [
              Text("Hello! Register to get started", style: TextStyles.font30),
              Gap(32),
              AppTextField(
                controller: cubit.usernameController,
                validator: AppValidators.validateUsername,
                hintText: "Username",
              ),
              Gap(15),
              AppTextField(
                controller: cubit.emailController,
                validator: AppValidators.validateEmail,
                hintText: "Email",
              ),
              Gap(15),
              AppTextField(
                controller: cubit.passwordController,
                validator: AppValidators.validatePassword,
                hintText: "Password",
                isPass: true,
              ),
              Gap(15),
              AppTextField(
                controller: cubit.passwordConfirmationController,
                validator: (value) =>
                    AppValidators.validatePasswordConfirmation(
                      value,
                      cubit.passwordController.text,
                    ),
                hintText: "Confirm password",
                isPass: true,
              ),
              Gap(30),
              MainButton(
                text: "Register",
                onPressed: () {
                  if (cubit.formKey.currentState!.validate()) {
                    cubit.register();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
