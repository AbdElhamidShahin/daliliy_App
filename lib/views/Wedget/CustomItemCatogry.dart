import 'package:flutter/material.dart';

class CustomItemCatogry extends StatelessWidget {
  const CustomItemCatogry({
    super.key,
    this.screenWidth,
    required this.imageUrl,
    required this.name,
    required this.description,
  });

  final double? screenWidth;
  final String name;
  final String description;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
      child: Container(
        height: 150,
        constraints: BoxConstraints(
          minHeight: 150,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28), color: Colors.white),
        child: Row(
          children: [
            // 1/5 for Icon
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.favorite_border, size: 32)),
            ),
            // 2/5 for text (title, subtitle, and rating)
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
                        name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth! * 0.06), // Dynamic font size
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        description,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth! * 0.05), // Dynamic font size
                      ),
                      // Your other widget content
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
                    imageUrl, // Use the passed imageUrl here
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // 1/5 Empty Space (Adjustable if needed)
            SizedBox(width: screenWidth! * 0.05),
          ],
        ),
      ),
    );
  }
}
