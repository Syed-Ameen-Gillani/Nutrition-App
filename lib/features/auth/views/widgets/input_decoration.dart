import 'package:flutter/material.dart';
import 'package:nutrovite/core/extensions/media_query_extensions.dart';

InputDecoration inputDecoration({
  required BuildContext context,
  required String labelText,
  String? hintText,
  Widget? suffixIcon,
}) {
  return InputDecoration(
    labelText: labelText,
    hintText: hintText ?? '',
    filled: true,
    fillColor: context.cScheme.surfaceContainerHighest,
    border: InputBorder.none,
    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide.none,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(color: Colors.red, width: 0.5),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(color: Colors.red, width: 1.0),
    ),
    suffixIcon: suffixIcon,
  );
}
