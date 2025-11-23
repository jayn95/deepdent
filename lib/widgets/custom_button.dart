import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final IconData? icon; // <-- make nullable
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;

  const CustomButton({
    super.key,
    required this.text,
    this.icon, // <-- now optional
    required this.onPressed,
    this.backgroundColor = const Color(0xFF532B88),
    this.textColor = Colors.white,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    // If NO icon → return a normal ElevatedButton
    if (icon == null) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 70),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    // If HAS icon → return ElevatedButton.icon
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 70),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      icon: Icon(icon, color: iconColor),
      label: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
