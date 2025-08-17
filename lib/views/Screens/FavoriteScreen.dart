import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/ItemProvider.dart';
import '../Wedget/CustomFavoriteItem.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<ItemProvider>(context);
    final favoriteItems = favoriteProvider.favorites;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        title: const Center(
          child: Text(
            'المفضلة',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF8F9FA),
      body: CustomScrollView(
        slivers: [
          favoriteItems.isEmpty
              ? SliverFillRemaining(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_outline_rounded,
                        size: 80,
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'لا يوجد عناصر في المفضله',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                )
              : SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final item = favoriteItems[index];
                        final uniqueHeroTag =
                            'favorite-item-${item.id}-${DateTime.now().millisecondsSinceEpoch}';

                        return Dismissible(
                          key: Key(item.id.toString()),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                          onDismissed: (_) {
                            favoriteProvider.removeFromFavorites(item);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Row(
                                  children: [
                                    Text(""),
                                    Spacer(),
                                    Text(
                                      "تم الحذف من المفضلة",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                backgroundColor: Colors.red[400],
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            );
                          },
                          child: Customfavoriteitem(
                            category: item,
                            uniqueHeroTag: uniqueHeroTag,
                          ),
                        );
                      },
                      childCount: favoriteItems.length,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
