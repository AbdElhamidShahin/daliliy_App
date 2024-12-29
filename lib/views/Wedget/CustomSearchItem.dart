import 'package:flutter/material.dart';

class CustomSearchItem extends StatelessWidget {
  const CustomSearchItem({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications_none_rounded,
            size: 34,
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'بتدور علي ايه ؟',
                prefixIcon:
                const Icon(Icons.search, color: Colors.grey),
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
