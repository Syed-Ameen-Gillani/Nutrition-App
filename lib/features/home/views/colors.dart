import 'package:flutter/material.dart';

class ColorPreviewScreen extends StatelessWidget {
  const ColorPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material 3 Color Preview'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          children: [
            ColorBox(color: colorScheme.primary, label: 'Primary'),
            ColorBox(color: colorScheme.onPrimary, label: 'On Primary'),
            ColorBox(color: colorScheme.secondary, label: 'Secondary'),
            ColorBox(color: colorScheme.onSecondary, label: 'On Secondary'),
            ColorBox(color: colorScheme.tertiary, label: 'Tertiary'),
            ColorBox(color: colorScheme.onTertiary, label: 'On Tertiary'),
            ColorBox(color: colorScheme.surface, label: 'Surface'),
            ColorBox(color: colorScheme.onSurface, label: 'On Surface'),
            ColorBox(
                color: colorScheme.surfaceContainerLowest,
                label: 'Surface Variant'),
            ColorBox(
                color: colorScheme.onSurfaceVariant,
                label: 'On Surface Variant'),
            ColorBox(color: colorScheme.surface, label: 'Background'),
            ColorBox(color: colorScheme.onSurface, label: 'On Background'),
            ColorBox(color: colorScheme.error, label: 'Error'),
            ColorBox(color: colorScheme.onError, label: 'On Error'),
            ColorBox(
                color: colorScheme.errorContainer, label: 'Error Container'),
            ColorBox(
                color: colorScheme.onErrorContainer,
                label: 'On Error Container'),
            ColorBox(color: colorScheme.outline, label: 'Outline'),
            ColorBox(color: colorScheme.shadow, label: 'Shadow'),
            ColorBox(
                color: colorScheme.primaryContainer,
                label: 'Primary Container'),
            ColorBox(
                color: colorScheme.onPrimaryContainer,
                label: 'On Primary Container'),
            ColorBox(
                color: colorScheme.secondaryContainer,
                label: 'Secondary Container'),
            ColorBox(
                color: colorScheme.onSecondaryContainer,
                label: 'On Secondary Container'),
            ColorBox(
                color: colorScheme.tertiaryContainer,
                label: 'Tertiary Container'),
            ColorBox(
                color: colorScheme.onTertiaryContainer,
                label: 'On Tertiary Container'),
            ColorBox(color: colorScheme.surfaceTint, label: 'Surface Tint'),
            ColorBox(
                color: colorScheme.inverseSurface, label: 'Inverse Surface'),
            ColorBox(
                color: colorScheme.onInverseSurface,
                label: 'On Inverse Surface'),
            ColorBox(
                color: colorScheme.inversePrimary, label: 'Inverse Primary'),
          ],
        ),
      ),
    );
  }
}

class ColorBox extends StatelessWidget {
  final Color color;
  final String label;

  const ColorBox({super.key, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            label,
            style: TextStyle(
              color:
                  color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
