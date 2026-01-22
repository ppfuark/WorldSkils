import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final IconData icon;
  final String label;
  final String hintText;
  final bool isPasswordField;
  final TextEditingController controller;

  const AppTextField({
    super.key,
    required this.icon,
    required this.label,
    required this.hintText,
    required this.isPasswordField,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: theme.tertiary,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: isPasswordField,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: theme.secondary),
            prefixIcon: Icon(icon, size: 20, color: theme.secondary),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 48,
              minHeight: 48,
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 16,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(999),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(999),
              borderSide: BorderSide(color: theme.tertiary, width: 1.2),
            ),
          ),
        ),
      ],
    );
  }
}
