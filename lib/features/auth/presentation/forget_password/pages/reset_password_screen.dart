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
import 'package:bookia/features/auth/presentation/widgets/auth_listener_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        authListener(
          context: context,
          state: state,
          navigationMethod: pushPage,
          routName: Routes.passwordChanged,
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
        body: _body(context),
      ),
    );
  }

  SingleChildScrollView _body(BuildContext context) {
    AuthCubit cubit = context.read<AuthCubit>();
    return SingleChildScrollView(
      child: BodyView(
        child: Form(
          key: cubit.formKey,
          child: Column(
            children: [
              Text("Create new password", style: TextStyles.font30),
              Gap(10),
              Text(
                "Your new password must be unique from those previously used.",
                style: TextStyles.font16.copyWith(color: AppColors.grayColor),
              ),
              Gap(32),
              AppTextField(
                controller: cubit.passwordController,
                hintText: "New Password",
                validator: AppValidators.validatePassword,
              ),
              Gap(15),
              AppTextField(
                controller: cubit.passwordConfirmationController,
                hintText: "Confirm Password",
                validator: (value) =>
                    AppValidators.validatePasswordConfirmation(
                      value,
                      cubit.passwordController.text,
                    ),
              ),
              Gap(38),
              MainButton(
                text: "Reset Password",
                onPressed: () {
                  if (cubit.formKey.currentState!.validate()) {
                    cubit.resetPassword();
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
