import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/helpers/app_validator.dart';
import 'package:bookia/core/helpers/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/app_back_btn.dart';
import 'package:bookia/core/widgets/app_text_field.dart';
import 'package:bookia/core/widgets/body_view.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:bookia/features/auth/presentation/widgets/auth_listener_widgets.dart';
import 'package:bookia/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});
  String enteredEmail = '';
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        authListener(
          context: context,
          state: state,
          navigationMethod: pushPage,
          routName: Routes.otp,
          extra: enteredEmail,
        );
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: AppBackBtn(),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(LocaleKeys.forgot_password_title.tr(), style: TextStyles.font30),
              Gap(10),
              Text(
                LocaleKeys.forgot_password_subtitle.tr(),
                style: TextStyles.font16.copyWith(color: AppColors.grayColor),
              ),
              Gap(32),
              AppTextField(
                controller: cubit.emailController,
                hintText: LocaleKeys.enter_email.tr(),
                validator: AppValidators.validateEmail,
                onChanged: (value) {
                  enteredEmail = value;
                },
              ),
              Gap(30),
              MainButton(
                text: LocaleKeys.send_code.tr(),
                onPressed: () {
                  if (cubit.formKey.currentState!.validate()) {
                    enteredEmail = cubit.emailController.text;
                    cubit.forgetPassword();
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
