import 'package:flutter/material.dart';

class AppBrandButton extends StatelessWidget {
  final String imagePath;

  const AppBrandButton({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(imagePath, height: 72, width: 72, fit: BoxFit.contain,),
      ),
    );
  }
}
