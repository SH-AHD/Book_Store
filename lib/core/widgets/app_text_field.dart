import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.suffixPath,
    this.prefixPath,
    this.isPass = false,
    this.isSearch = false,
    this.validator,
    this.onChanged,
  });
  final String hintText;
  final String? suffixPath;
  final String? prefixPath;
  final bool isPass;
  final bool isSearch;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool obscure;

  @override
  void initState() {
    super.initState();
    obscure = widget.isPass;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        setState(() {});
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
      validator: widget.validator,
      obscureText: obscure,
      controller: widget.controller,

      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.prefixPath != null
            ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPic(path: widget.prefixPath!),
              )
            : null,

        suffixIcon: widget.isPass
            ? IconButton(
                color: AppColors.grayColor,
                onPressed: () {
                  setState(() {
                    obscure = !obscure;
                  });
                },
                icon: Icon(
                  obscure ? Icons.visibility_off : Icons.remove_red_eye,
                ),
              )
            : (widget.isSearch &&
                      widget.controller != null &&
                      widget.controller!.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, color: AppColors.grayColor),
                      onPressed: () {
                        widget.controller!.clear();
                        if (widget.onChanged != null) widget.onChanged!("");
                        setState(() {});
                      },
                    )
                  : (widget.suffixPath != null
                        ? Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgPic(path: widget.suffixPath!),
                          )
                        : null)),

        filled: true,
        fillColor: AppColors.whiteColor,
      ),
      onTapUpOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }
}
