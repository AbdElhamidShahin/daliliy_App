import 'package:flutter/material.dart';

Padding CustomItemSetteings(
    String text, final VoidCallback? onPressed, IconData? icon,Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Column(
      children: [
        const SizedBox(height: 16),
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_back_ios, size: 28, color:  Colors.black),
            ),
            Spacer(),
            TextButton(
              onPressed: onPressed,
              child: Text(
                text,
                style:  TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color:Colors.black),
              ),
            ),
            Icon(
              icon,
              size: 32,
              color: color,
            ),
          ],
        ),
      ],
    ),
  );
}
