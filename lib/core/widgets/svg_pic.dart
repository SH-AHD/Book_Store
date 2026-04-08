import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgPic extends StatelessWidget {
  const SvgPic({super.key, required this.path, this.color, this.w});
  final String path;
  final Color? color;
  final double? w;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: w,
      colorFilter: color != null
          ? ColorFilter.mode(color!, BlendMode.srcIn)
          : null,
    );
  }
}
