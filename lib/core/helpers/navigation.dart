import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<T?> pushPage<T>(BuildContext context, String routeName, {Object? extra}) {
  return context.push<T>(routeName, extra: extra);
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
