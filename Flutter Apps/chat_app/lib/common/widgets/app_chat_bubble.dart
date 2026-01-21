import 'package:flutter/material.dart';

class AppChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const AppChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: isCurrentUser
            ? BorderRadius.only(
                bottomLeft: Radius.circular(12),
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              )
            : BorderRadius.only(
                bottomRight: Radius.circular(12),
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
        color: isCurrentUser ? Colors.green : Colors.white,
      ),
      child: Text(
        message,
        style: TextStyle(color: isCurrentUser ? Colors.white : Colors.black),
      ),
    );
  }
}
