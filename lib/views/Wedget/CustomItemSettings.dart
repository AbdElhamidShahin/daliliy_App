import 'package:flutter/material.dart';

Padding CustomItemSetteings(String text, final VoidCallback? onPressed) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Column(
      children: [
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: onPressed,
              child: Text(
                text,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white),
              ),
            ),
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 0),
          child: Divider(
            color: Colors.black12,
          ),
        ),
      ],
    ),
  );
}
