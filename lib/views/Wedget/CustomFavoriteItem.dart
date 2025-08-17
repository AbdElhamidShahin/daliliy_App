import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Tourism_app/models/Item/Item.dart'; // ده الصحيح

import '../../viewmodels/ItemProvider.dart';
import '../Screens/CustomDetailsScreen.dart';

class Customfavoriteitem extends StatelessWidget {
  final Category category;
  final String uniqueHeroTag;

  const Customfavoriteitem({
    super.key,
    required this.category,
    required this.uniqueHeroTag,
  });

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<ItemProvider>(context);
    return  Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CustomDetailsScreen(
                category: category,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Favorite button
              IconButton(
                icon: const Icon(
                  Icons.favorite_rounded,
                  color: Colors.redAccent,
                  size: 32,
                ),
                onPressed: () {
                  favoriteProvider
                      .removeFromFavorites(category);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    SnackBar(
                      content: const Text(
                          "تم الحذف من المفضلة"),
                      backgroundColor: Colors.redAccent,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
              ),

              // Item details
              Expanded(
                child: Padding(
                  padding:
                  const EdgeInsets.only(right: 12),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.end,
                    children: [
                      Text(
                        category.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        category.description.length > 30
                            ? category.description
                            .substring(0, 30)
                            : category.description,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),

              // Product image with Hero animation
              Hero(
                tag: uniqueHeroTag,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    category.imageUrl,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Container(
                          width: 120,
                          height: 120,
                          color: Colors.grey[200],
                          child: Image.asset(
                            'assets/Image/logo.png',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
