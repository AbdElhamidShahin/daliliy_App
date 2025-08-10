import 'package:flutter/material.dart';
import '../../Color.dart';

class CustomSearchBar extends StatelessWidget {
  final Function(String) onSearch; // callback function
  final TextEditingController controller = TextEditingController();

  CustomSearchBar({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none_rounded, size: 34, color: AppColors.textPrimary),
        ),
        Expanded(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.card,
                boxShadow: const [BoxShadow(color: AppColors.shadow, spreadRadius: 2, blurRadius: 5)],
              ),
              child: TextField(
                controller: controller,
                onChanged: (value) {
                  onSearch(value); // call search on typing
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'ما الذي تبحث عنه؟',
                  prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary, size: 28),
                  hintStyle: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
