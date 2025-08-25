import 'package:flutter/material.dart';

Widget CustomItemSetteings(
    String text,
    final VoidCallback? onPressed,
    IconData? icon,
    bool isDarkMode,
    ) {
  final textColor = isDarkMode ? Colors.white : Colors.black;
  final iconColor = isDarkMode ? Colors.grey[400] : Colors.black54;

  return Column(
    children: [
      ListTile(
        leading:Icon(
          Icons.arrow_back_ios,
          size: 18,
          color: iconColor,
        ),
        title: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.right,
        ),
        trailing: Icon(icon, color: iconColor, size: 26),
        onTap: onPressed,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      Divider(
        height: 1,
        color: isDarkMode ? Colors.grey[700] : Colors.grey.withOpacity(0.3),
        thickness: 1,
        indent: 16,
        endIndent: 16,
      ),
    ],
  );
}
