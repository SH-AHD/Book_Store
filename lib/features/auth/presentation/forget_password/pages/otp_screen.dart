import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/helpers/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/body_view.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:bookia/features/auth/presentation/forget_password/widgets/pin_field.dart';
import 'package:bookia/features/auth/presentation/widgets/auth_listener_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});
  String enteredCode = '';

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        authListener(
          context: context,
          state: state,
          navigationMethod: pushPage,
          routName: Routes.resetPass,
          extra: enteredCode,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("OTP Verification", style: TextStyles.font30),
              Gap(10),
              Text(
                "Enter the verification code we just sent on your email address.",
                style: TextStyles.font16.copyWith(color: AppColors.grayColor),
              ),
              Gap(35),
              //Pinput
              Center(
                child: PinField(
                  onComplete: (p0) => {
                    cubit.verifyCodeController.text = p0,
                    cubit.sendCode(p0),
                    cubit.checkOtpCode(),
                  },
                ),
              ),
              Gap(35),
              MainButton(
                text: "Verify",
                onPressed: () {
                  if (cubit.formKey.currentState!.validate()) {
                    enteredCode = cubit.verifyCodeController.text;
                    cubit.checkOtpCode();
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
