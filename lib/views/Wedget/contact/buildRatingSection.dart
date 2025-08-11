import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../viewmodels/cubit/Bloc.dart';
import '../../../viewmodels/cubit/states.dart';
import '../StarRating.dart';

Widget buildRatingSection(BuildContext context) {
  return Column(
    children: [
      const Text(
        "شاركنا رأيك",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      const SizedBox(height: 20),
      BlocBuilder<DalilyCubit, DalilyState>(
        builder: (context, state) {
          return StarRating(
            size: 40,
            rating: DalilyCubit.get(context).currentRating,
            onRatingChanged: (rating) {
              DalilyCubit.get(context).updateRating(rating);
            },
          );
        },
      ),
      const SizedBox(height: 24),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            // يمكنك إضافة أي إجراء إضافي هنا عند الضغط على الزر
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('شكراً لتقييمك!'),
                duration: Duration(seconds: 2),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 5,
          ),
          child: const Text(
            'إرسال التقييم',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget ratingWedgit(BuildContext context ) {
  return BlocBuilder<DalilyCubit, DalilyState>(
    builder: (context, state) {
      final cubit = DalilyCubit.get(context);
      final avg = cubit.averageRating;

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.amber.withOpacity(0.15),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.amber.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.star_rounded, color: Colors.amber[700], size: 24),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  avg.toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
