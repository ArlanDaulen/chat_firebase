import 'package:flutter/material.dart';

class CTextField extends StatelessWidget {
  const CTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.obscureText = false,
    this.isDense = false,
    this.focusNode,
    this.validator,
  });
  final TextEditingController? controller;
  final String? hintText;
  final bool obscureText;
  final bool isDense;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(hintText: hintText, isDense: isDense),
      obscureText: obscureText,
      focusNode: focusNode,
    );
  }
}
