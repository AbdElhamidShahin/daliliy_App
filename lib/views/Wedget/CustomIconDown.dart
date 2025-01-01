import 'package:flutter/material.dart';

Widget CustomIconDown(
  IconData icon,
  Color? color,
) {
  return Padding(
    padding: const EdgeInsets.only(top: 50, right: 10, bottom: 20),
    child: Container(
      width: 120,
      height: 45,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(28), color: color),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    ),
  );
}
