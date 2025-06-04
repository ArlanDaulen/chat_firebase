import 'package:flutter/material.dart';

class CTextField extends StatelessWidget {
  const CTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.obscureText = false,
    this.isDense = false,
    this.focusNode,
  });
  final TextEditingController? controller;
  final String? hintText;
  final bool obscureText;
  final bool isDense;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(hintText: hintText, isDense: isDense),
      obscureText: obscureText,
      focusNode: focusNode,
    );
  }
}
