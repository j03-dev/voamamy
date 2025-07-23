import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback action;
  final String text;
  final IconData? icon;
  final Color backgroundColor;
  final Color textColor;

  const RoundedButton({
    super.key,
    required this.text,
    required this.action,
    this.icon,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 9.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) Icon(icon, color: textColor),
            if (icon != null) const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 20.0,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
