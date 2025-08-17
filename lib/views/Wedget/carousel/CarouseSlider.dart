
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../viewmodels/cubit/Bloc.dart';
import '../../../viewmodels/cubit/states.dart';

class CustomCarouselSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => DalilyCubit(),
      child: BlocConsumer<DalilyCubit, DalilyState>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          var cubit = DalilyCubit.get(context);
          return Column(
            children: [
              CarouselSlider(
                items: cubit.imageUrls.map((url) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.network(
                      url,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.9,
                  onPageChanged: (index, reason) {
                    cubit.changeIndex(index);
                  },
                ),
              ),
              const SizedBox(height: 15),
              CarouselIndicator(
                count: cubit.imageUrls.length,
                activeColor: Colors.blue,
                color: Colors.grey.withOpacity(0.5),
                width: 16,
                height: 8,
                index: cubit.currentIndex,
              ),
            ],
          );
        },
      ),
    );
  }
}
