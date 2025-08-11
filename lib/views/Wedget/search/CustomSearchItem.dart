import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';

class CustomSearchBar extends StatelessWidget {
  final Function(String) onSearch; // callback function
  final TextEditingController controller = TextEditingController();

  CustomSearchBar({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutQuint,
      height: 54,
      margin: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: AppColors.searchBar,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded,
                size: 28, color: AppColors.textPrimary),
          ),
          Expanded(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Container(

                child: TextField(
                  controller: controller,
                  onChanged: (value) {
                    onSearch(value); // call search on typing
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'ما الذي تبحث عنه؟',
                    prefixIcon: const Icon(Icons.search,
                        color: AppColors.textSecondary, size: 28),
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
      ),
    );
  }
}
