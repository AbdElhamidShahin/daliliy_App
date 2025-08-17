import 'package:flutter/material.dart';

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
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.black87),
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
        ),
      ],
    ),
  );
}
