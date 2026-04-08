import 'package:flutter/material.dart';

class BodyView extends StatelessWidget {
  const BodyView({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(22),
  });
  final Widget child;
  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) {
    return Padding(padding: padding, child: child);
  }
}
