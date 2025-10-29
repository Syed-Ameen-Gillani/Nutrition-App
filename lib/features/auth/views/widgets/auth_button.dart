import 'package:flutter/material.dart';
import 'package:nutrovite/core/extensions/media_query_extensions.dart';

class CustomSubmitButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final VoidCallback? onLongPressed;

  const CustomSubmitButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.onLongPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: FilledButton(
        onPressed: onPressed,
        onLongPress: onLongPressed,
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          backgroundColor: Theme.of(context)
              .colorScheme
              .primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          textStyle: context.tTheme.bodySmall!.copyWith(
            color: context.cScheme.onPrimaryContainer,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: Text(
          label,
          style: context.tTheme.bodyMedium!.copyWith(
            color: context.cScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
