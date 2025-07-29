import 'package:flutter/material.dart';
import 'package:Tourism_app/core/constants/color.dart';
import '../../core/helpers/StarRating.dart';
import '../../models/Item/Item.dart';

class CustomItemCategory extends StatelessWidget {
  final Category category;
  final double? width;
  final double? height;

  const CustomItemCategory({
    super.key,
    required this.category,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final cardWidth = width ?? size.width * 0.9;
    final cardHeight = height ?? size.height * 0.22;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          // Navigate to details screen
        },
        child: Stack(
          children: [
            // Background Image with overlay
            Container(
              width: cardWidth,
              height: cardHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage(category.imageUrl ?? ''),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3),
                    BlendMode.darken,
                  ),
                ),
              ),
            ),

            // Content
            Container(
              width: cardWidth,
              height: cardHeight,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    category.name ?? "لا يوجد",
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Rating and Description
                  Row(
                    children: [
                      StarRating(
                        rating: 4.0,
                        size: 18,
                        color: Colors.amber,
                        onRatingChanged: (newRating) {
                          print('New Rating: $newRating');
                        },
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '5.0',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Description
                  Text(
                    category.description ?? "لا يوجد",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withOpacity(0.9),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Favorite Button
            Positioned(
              top: 12,
              right: 12,
              child: IconButton(
                icon: Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                  size: 28,
                ),
                onPressed: () {
                  // Add to favorites
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}