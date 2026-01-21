import 'package:flutter/material.dart';

class AppUserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const AppUserTile({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        decoration: BoxDecoration(
          color: theme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [Icon(Icons.person), SizedBox(width: 4), Text(text)],
          ),
        ),
      ),
    );
  }
}
