import 'package:Tourism_app/models/Item.dart' as item_model;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/helpers/StarRating.dart';
import '../../models/Item.dart';
import 'IconFavorite.dart';

class CustomItemCatogry extends StatefulWidget {
  const CustomItemCatogry({
    super.key,
    this.screenWidth,
    required this.imageUrl,
    required this.name,
    required this.description,
    this.category,
  });

  final item_model.Category? category; // إصلاح التعارض باستخدام alias
  final double? screenWidth;
  final String name;
  final String description;
  final String imageUrl;

  @override
  State<CustomItemCatogry> createState() => _CustomItemCatogryState();
}

class _CustomItemCatogryState extends State<CustomItemCatogry> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = false; // القيمة الافتراضية
  }

  @override
  Widget build(BuildContext context) {
    double _currentRating = 4.0;

    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
      child: Container(
        height: 150,
        constraints: const BoxConstraints(minHeight: 150),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: Colors.white,
        ),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                final category = Category(
                  name: widget.name,
                  description: widget.description,
                  imageUrl: widget.imageUrl,
                );

                Provider.of<ItemProvider>(context, listen: false)
                    .addToFavorites(category);

                setState(() {
                  isFavorite = !isFavorite;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    size: 32,
                    color: isFavorite ? Colors.red : Colors.grey,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 12.0),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        widget.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: widget.screenWidth! *
                                0.06), // Dynamic font size
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        widget.description,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: widget.screenWidth! *
                                0.05), // Dynamic font size
                      ),
                      StarRating(
                        rating: _currentRating,
                        onRatingChanged: (newRating) {
                          // Example: Handle rating change
                          print('New Rating: $newRating');
                        },
                      ),                    // Your other widget content
                    ],
                  ),
                ),
              ),
            ),
            // 1/5 for Image (using FractionallySizedBox to scale image)
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FractionallySizedBox(
                  alignment: Alignment.center,
                  heightFactor: 0.8,
                  widthFactor: 1.2, // Ensures the image takes the full height
                  child: Image.network(
                    widget.imageUrl, // Use the passed imageUrl here
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // 1/5 Empty Space (Adjustable if needed)
            SizedBox(width: widget.screenWidth! * 0.05),
          ],
        ),
      ),
    );
  }
}
