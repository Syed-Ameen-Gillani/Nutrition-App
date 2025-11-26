import 'package:flutter/material.dart';
import 'package:nutrovite/core/extensions/media_query_extensions.dart';
import 'package:nutrovite/features/auth/views/widgets/input_decoration.dart';

class NeutroviteTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final bool enabled;
  final FormFieldValidator<String>? validator;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;

  const NeutroviteTextField({
    super.key,
    required this.controller,
    required this.label,
    this.obscureText = false,
    this.enabled = true,
    this.validator,
    this.errorBorder,
    this.focusedErrorBorder,
    this.enabledBorder,
    this.focusedBorder,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      enabled: enabled,
      style: context.tTheme.bodyMedium!.copyWith(
        color: context.cScheme.onSurface,
      ),
      decoration: inputDecoration(
        context: context,
        labelText: label,
        hintText: label,
      ),
      validator: validator,
    );
  }
}
