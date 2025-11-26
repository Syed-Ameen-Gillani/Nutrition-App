import 'package:flutter/material.dart';

class ProfileField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final bool enabled;
  final String? Function(String?) validator;
  final Widget? suffixIcon;
  final bool? obscureText;
  final ValueChanged<String?>? onChanged;

  const ProfileField({
    super.key,
    required this.label,
    required this.controller,
    required this.icon,
    required this.enabled,
    required this.validator,
    this.suffixIcon,
    this.onChanged,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        enabled: enabled,
        controller: controller,
        obscureText: obscureText ?? false,
        validator: validator,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: enabled
                  ? Theme.of(context).iconTheme.color
                  : Theme.of(context).disabledColor,
            ),
        decoration: InputDecoration(
          suffixIcon: (suffixIcon != null) ? suffixIcon : null,
          prefixIcon: Icon(
            icon,
            color: enabled
                ? Theme.of(context).iconTheme.color
                : Theme.of(context).disabledColor,
          ),
          labelText: label,
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1.2,
              color: enabled
                  ? Theme.of(context).iconTheme.color ?? Colors.transparent
                  : Theme.of(context).disabledColor,
            ),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1.2,
              color: enabled
                  ? Theme.of(context).iconTheme.color ?? Colors.transparent
                  : Theme.of(context).disabledColor,
            ),
          ),
        ),
        onChanged: enabled ? onChanged : null,
      ),
    );
  }
}

class CustomDropdown extends StatelessWidget {
  final String selectedValue;
  final String label;
  final Icon icon;
  final List<String> items;
  final bool enabled;
  final ValueChanged<String?> onChanged;
  final Widget? suffixIcon;

  const CustomDropdown({
    super.key,
    required this.selectedValue,
    required this.label,
    required this.icon,
    required this.items,
    required this.enabled,
    required this.onChanged,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        icon: const Icon(Icons.arrow_drop_down),
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Theme.of(context).colorScheme.onSurface),
        decoration: InputDecoration(
          suffixIcon: suffixIcon != null
              ? IconTheme(
                  data: IconThemeData(
                    color: enabled
                        ? Theme.of(context).iconTheme.color
                        : Theme.of(context).disabledColor,
                  ),
                  child: suffixIcon!,
                )
              : null,
          prefixIcon: IconTheme(
            data: IconThemeData(
              color: enabled
                  ? Theme.of(context).iconTheme.color
                  : Theme.of(context)
                      .disabledColor, // Fade prefix icon when disabled
            ),
            child: icon,
          ),
          labelText: label,
          labelStyle: TextStyle(
            color: enabled
                ? Theme.of(context).inputDecorationTheme.labelStyle?.color
                : Theme.of(context).disabledColor, // Fade label when disabled
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1.2,
              color: enabled
                  ? Theme.of(context).iconTheme.color ?? Colors.transparent
                  : Theme.of(context).disabledColor,
            ),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1.2,
              color: enabled
                  ? Theme.of(context).iconTheme.color ?? Colors.transparent
                  : Theme.of(context).disabledColor,
            ),
          ),
        ),
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: enabled ? onChanged : null,
      ),
    );
  }
}
