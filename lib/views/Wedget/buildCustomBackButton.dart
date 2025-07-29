import 'package:flutter/material.dart';

Widget buildCustomBackButton(BuildContext context) {
  return Material(
    color: Colors.white.withOpacity(0.2),
    borderRadius: BorderRadius.circular(12),
    elevation: 2,
    child: InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => Navigator.pop(context),
      child: Container(
        width: 48,
        height: 48,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.3)),
        ),
        child: const Icon(Icons.arrow_back, color: Colors.white),
      ),
    ),
  );
}
