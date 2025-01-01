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
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        starCount,
            (index) {
          return GestureDetector(
            onTap: onRatingChanged != null
                ? () => onRatingChanged!(index + 1.0)
                : null,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Icon(
                index < rating ? Icons.star : Icons.star_border,
                color: color,
                size: 50.0,
              ),
            ),
          );
        },
      ),
    );
  }
}
