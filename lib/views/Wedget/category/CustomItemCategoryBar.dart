
import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

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
        margin: const EdgeInsets.only(left: 14),
        child: Column(
          children: [
            Container(
              width: 85,
              height: 85,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  )
                ],
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.blue.shade50,
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  item['urlImage'],
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
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}