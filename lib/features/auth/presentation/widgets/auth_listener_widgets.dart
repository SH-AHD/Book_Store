import 'package:bookia/core/helpers/navigation.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';

void authListener({
  required BuildContext context,
  required AuthState state,
  required void Function(BuildContext, String, {Object? extra})
  navigationMethod,
  required String routName,
  String? extra,
}) {
  if (state is AuthSuccessState) {
    popPage(context);
    navigationMethod(context, routName, extra: extra);
  } else if (state is AuthErrorState) {
    popPage(context);
    showErrorDialog(context, state.error);
  } else if (state is AuthLoadingState) {
    showLoadingDialog(context);
  }
}
