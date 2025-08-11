import 'package:flutter/material.dart';



class CustomIconDown extends StatelessWidget {
   CustomIconDown({super.key, required this.icon, required this.color,required this.onTap});
  void Function() onTap;
   final IconData icon;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 50, right: 10, bottom: 20),
        child: Container(
          width: 120,
          height: 45,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28), color: color),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

