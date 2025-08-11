
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../viewmodels/cubit/Bloc.dart';
import '../../../viewmodels/cubit/states.dart';

class CustomCarouselSlider extends StatelessWidget {
  CustomCarouselSlider({super.key});

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
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(url, fit: BoxFit.cover),
                        ),
                      );
                    },
                  );
                }).toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  onPageChanged: (index, reason) {
                    cubit.changeIndex(index); // استدعاء دالة تغيير المؤشر
                  },
                ),
              ),
              const SizedBox(height: 25),
              BlocBuilder<DalilyCubit, DalilyState>(
                builder: (context, state) {
                  return CarouselIndicator(
                    count: cubit.imageUrls.length,
                    activeColor: Colors.blue,
                    color: Colors.grey,
                    index: cubit.currentIndex,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}