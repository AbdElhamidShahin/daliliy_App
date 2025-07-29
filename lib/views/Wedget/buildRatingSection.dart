import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/helpers/StarRating.dart';
import '../../models/cubit/Bloc.dart';
import '../../models/cubit/states.dart';

Widget buildRatingSection(BuildContext context) {
  return Column(
    children: [
      const Text(
        "شاركنا رأيك",
        style: const TextStyle(
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
            rating: DalilyCubit.get(context).rating,
            onRatingChanged: (rating) {
              DalilyCubit.get(context).RatingState(rating);
            },
          );
        },
      ),
      const SizedBox(height: 24),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
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
