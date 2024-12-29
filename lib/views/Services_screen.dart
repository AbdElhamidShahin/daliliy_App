import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/helpers/StarRating.dart';
import '../models/cubit/Bloc.dart';
import '../models/cubit/states.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => DalilyCubit(),
      child: BlocConsumer<DalilyCubit, DalilyState>(
        listener: (context,state){},
        builder: (context, state) {
          if (state is UpdateRatingState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("اختر تقييمك:",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                SizedBox(height: 20),
                StarRating(
                  rating: state.rating,
                  onRatingChanged: (newRating) {
                    context.read<DalilyCubit>().updateRating(newRating);
                  },
                ),
                SizedBox(height: 20),
                Text("التقييم الحالي: ${state.rating}",
                    style: TextStyle(fontSize: 18)),
              ],
            );
          } else {
            return Center(
                child: Text("التقييم غير متاح"));
          }
        },
      ),
    );
  }
}
