import 'package:Tourism_app/core/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../core/helpers/StarRating.dart';
import '../../models/Item.dart';
import '../../models/cubit/Bloc.dart';
import '../../models/cubit/states.dart';
import 'IconFavorite.dart';

class CustomItemCategory extends StatelessWidget {
  const CustomItemCategory({
    super.key,
    this.screenWidth,
    required this.imageUrl,
    required this.name,
    required this.description,
    this.category,
    this.screenHeight,
  });

  final Category? category;
  final double? screenWidth;
  final double? screenHeight;

  final String name;
  final String description;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    double _currentRating = 4.0;

    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 12, right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Iconfavorite(
                      category: Category(
                          name: name,
                          description: description,
                          imageUrl: imageUrl)),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12),
                          Text(
                            name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth! * 0.06, // حجم خط ديناميكي
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            description,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth! * 0.05, // حجم خط ديناميكي
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 16),
                                child: StarRating(
                                  rating: _currentRating,
                                  onRatingChanged: (newRating) {
                                    // معالجة تغيير التقييم
                                    print('New Rating: $newRating');
                                  },
                                ),
                              ),
                              Center(
                                  child: Text(
                                '  5.0',
                                style: TextStyle(
                                    color: colorA,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      height: 100,
                      width: 50,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
