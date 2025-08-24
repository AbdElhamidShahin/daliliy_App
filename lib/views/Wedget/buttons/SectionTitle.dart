import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

class SectionTitleWithIcon extends StatelessWidget {
  final String title;
  final IconData icon;

  const SectionTitleWithIcon({
    super.key,
    required this.title,
    required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(width: 8),
          Icon(icon, color: Colors.blue, size: 22),
        ],
      ),
    );
  }
}