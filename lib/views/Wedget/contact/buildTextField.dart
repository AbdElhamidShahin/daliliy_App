import 'package:flutter/material.dart';

Widget buildTextField(
    TextEditingController controller,
    String label, {
      IconData? icon,
    }) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Directionality(
      textDirection: TextDirection.rtl, // النص من اليمين لليسار
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 24, color: Colors.black87),
        decoration: InputDecoration(
          labelText: '$label',
          labelStyle: const TextStyle(
            color: Color(0xFF4A4A4A),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          suffixIcon: icon != null
              ? Icon(
            icon,
            color: Colors.teal,
            size: 28,
          )
              : null, // أيقونة أقصى الشمال
          filled: true,
          fillColor: const Color(0xFFF9F9F9), // لون خلفية الحقل
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.teal.shade200,
              width: 1.2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.teal.shade100,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.teal.shade400,
              width: 1.5,
            ),
          ),
          contentPadding:
          const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        ),
      ),
    ),
  );
}