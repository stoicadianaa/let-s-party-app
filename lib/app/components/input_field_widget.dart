import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final Function(String?) onChanged;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  String initialValue;

  InputField({
    required this.onChanged,
    required this.hintText,
    this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.suffixIcon,
    this.textInputAction,
    this.initialValue = '',
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      keyboardType: keyboardType ?? TextInputType.text,
      textInputAction: textInputAction,
      initialValue: initialValue,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        border: const OutlineInputBorder(),
        hintText: hintText,
        filled: true,
      ),
    );
  }
}
