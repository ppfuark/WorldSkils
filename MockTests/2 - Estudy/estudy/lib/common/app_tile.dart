import 'package:flutter/material.dart';

class AppTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;

  final bool isEditable;
  final void Function()? onEdit;

  final bool isDeletable;
  final Function()? onDelete;

  final bool block;

  const AppTile({
    super.key,
    required this.title,
    required this.icon,
    required this.isEditable,
    this.onEdit,
    required this.isDeletable,
    this.onDelete,
    this.subtitle,
    required this.block,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.tertiary),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: theme.tertiary,
                  borderRadius: BorderRadius.circular(999),
                ),
                padding: EdgeInsets.all(6),
                child: Icon(icon, color: Colors.white, size: 32),
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 180,
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      title,
                      style: TextStyle(
                        color: theme.tertiary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle ?? "",
                    style: TextStyle(color: theme.secondary),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(width: 6),
          Row(
            children: [
              Builder(
                builder: (context) {
                  if (isEditable) {
                    return Container(
                      decoration: BoxDecoration(
                        color: theme.primary,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: IconButton(
                        onPressed: onEdit,
                        icon: Icon(Icons.edit_outlined, color: Colors.white),
                      ),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
              SizedBox(width: 4),
              Builder(
                builder: (context) {
                  if (isDeletable) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: IconButton(
                        onPressed: onDelete,
                        icon: block
                            ? Icon(Icons.block_outlined, color: Colors.white)
                            : Icon(Icons.delete_outlined, color: Colors.white),
                      ),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
