import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final Color color;
  final void Function(double)? onRatingChanged;

  const StarRating({
    Key? key,
    this.starCount = 5,
    required this.rating,
    this.color = Colors.amber,
    this.onRatingChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // إضافة فاصل بين النجوم
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        starCount,
            (index) {
          return GestureDetector(
            onTap: onRatingChanged != null
                ? () => onRatingChanged!(index + 1.0)
                : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0), // إضافة فاصل بين النجوم
              child: Icon(
                index < rating ? Icons.star : Icons.star_border,
                color: color,
                size: 24.0,
              ),
            ),
          );
        },
      ),
    );
  }
}