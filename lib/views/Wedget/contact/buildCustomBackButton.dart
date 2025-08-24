import 'package:flutter/material.dart';

Widget buildCustomBackButton(BuildContext context) {
  return Material(
    color: Colors.white.withOpacity(0.2),
    borderRadius: BorderRadius.circular(100),
    elevation: 2,
    child: InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: () => Navigator.pop(context),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: Colors.white.withOpacity(0.3)),
        ),
        child:const Center(child:  Icon(Icons.arrow_forward_ios_rounded, color: Colors.white)),
      ),
    ),
  );
}
