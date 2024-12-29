import 'package:flutter/material.dart';

class CustomItemCategoryBar extends StatelessWidget {
  final Map<String, dynamic> item;

  const CustomItemCategoryBar({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item['onTap'] != null ? () => item['onTap'](context) : null,
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // محاذاة العناصر في المنتصف
          mainAxisSize: MainAxisSize.min, // استخدام المساحة التي يحتاجها المحتوى فقط
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.black12,
                  width: 4,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 4,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  item['urlImage']!,
                  height: 100,
                  width: 100,
                  fit: BoxFit.contain, // الحفاظ على الأبعاد داخل المساحة المحددة
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 90, // تحديد عرض الحاوية
                child: Text(
                  item['name']!,
                  style: const TextStyle(
                    fontSize: 16, // تحديد حجم النص
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis, // في حالة زيادة النص، يتم تقليصه
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
