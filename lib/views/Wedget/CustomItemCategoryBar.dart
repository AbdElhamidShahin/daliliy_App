
import 'package:flutter/material.dart';

import '../../Color.dart';

class CategoryList extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  const CategoryList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.builder(

          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          itemBuilder: (context, index) => CategoryItem(item: items[index]),
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final Map<String, dynamic> item;
  const CategoryItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => item['onTap']?.call(context),
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(left: 12),
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [BoxShadow(color: AppColors.shadow, spreadRadius: 1, blurRadius: 4)],
                image: DecorationImage(
                  image: AssetImage(item['urlImage']),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item['name'],
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}