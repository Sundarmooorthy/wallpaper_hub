import 'package:flutter/material.dart';
import 'package:wallpaper_hub/my_app_exports.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextStyle? hintStyle;
  final Color fillColor;
  final EdgeInsetsGeometry contentPadding;
  final BorderRadius borderRadius;
  final Function(String?)? onSaved;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    this.hintText = 'Full name',
    this.hintStyle,
    this.fillColor = const Color(0xFFF5FCF9),
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
    this.borderRadius = const BorderRadius.all(Radius.circular(50)),
    this.onSaved,
    this.controller,
    this.textInputType,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        hintStyle:
            hintStyle ?? AppTextStyle.normal16(color: Colors.grey.shade600),
        fillColor: fillColor,
        contentPadding: contentPadding,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: borderRadius,
        ),
      ),
      onSaved: onSaved,
      keyboardType: textInputType,
      validator: validator,
    );
  }
}
