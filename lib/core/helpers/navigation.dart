import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void pushPage(BuildContext context, String routeName, {Object? extra}) {
  context.push(routeName, extra: extra);
}

void pushReplacementPage(
  BuildContext context,
  String routeName, {
  Object? extra,
}) {
  context.pushReplacement(routeName, extra: extra);
}

void pushAndRemoveUntilPage(
  BuildContext context,
  String routeName, {
  Object? extra,
}) {
  context.go(routeName, extra: extra);
}

void popPage(BuildContext context) {
  context.pop();
}
