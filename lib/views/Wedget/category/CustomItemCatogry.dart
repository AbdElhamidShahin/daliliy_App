import 'package:flutter/material.dart';
import '../../../models/Item/Item.dart';
import '../../../utils/app_colors.dart';
import '../contact/buildRatingSection.dart';

class CustomItemCategory extends StatelessWidget {
  const CustomItemCategory({
    super.key,
    required this.category,
    this.onTap,
    this.imageWidth = 130,
  });
  final Category category;
  final VoidCallback? onTap;
  final double imageWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(
        right: 16,
        left: 16,
        bottom: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: isDarkMode ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          splashColor: colorA.withOpacity(0.2),
          highlightColor: colorA.withOpacity(0.1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: IconButton(
                    onPressed: () {},
                    icon:const Icon(
                      Icons.arrow_back_ios,
                      size: 28,
                      color: Colors.black,
                    )),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // العنوان وزر المفضلة
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const    SizedBox(
                            width: 8,
                          ),
                          Flexible(
                            child: Text(
                              category.name ?? "لا يوجد اسم",
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color:
                                    isDarkMode ? Colors.white : Colors.black87,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      ratingWedgit(context),
                    ],
                  ),
                ),
              ),
              const  SizedBox(
                width: 12,
              ),
              ClipRRect(
                borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(14),
                ),
                child: Stack(
                  children: [
                    Container(
                      width: imageWidth * 0.5,
                      height: imageWidth * 0.5,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.black.withOpacity(0.3),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    Image.network(
                      category.imageUrl,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/Image/logo.png',
                          width: imageWidth * 0.9,
                          height: imageWidth * 0.9,
                        );
                      },
                      width: imageWidth,
                      height: imageWidth * 0.9,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
