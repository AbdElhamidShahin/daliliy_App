import 'package:flutter/material.dart';

<<<<<<< HEAD
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
=======
Padding CustomItemSetteings(
  String text,
  final VoidCallback? onPressed,
  IconData? icon,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Column(
      children: [
        const SizedBox(height: 16),
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_back_ios, size: 28, color: Colors.black),
            ),
            Spacer(),
            TextButton(
              onPressed: onPressed,
              child: Text(
                text,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                    color: Colors.black.withOpacity(.6)),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: Colors.grey.withOpacity(.3)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  icon,
                  size: 32,
                  color: Colors.black
                      .withOpacity(0.7), // وسط بين black87 و black54
                ),
              ),
            ),
          ],
>>>>>>> origin/main
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
