// تحسينات على السلايدر
import 'package:carousel_slider/carousel_slider.dart' show CarouselSlider, CarouselOptions;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../viewmodels/cubit/Bloc.dart' show DalilyCubit;
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
                  return Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.network(
                        url,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: cubit.imageUrls.asMap().entries.map((entry) {
                  return Container(
                    width: cubit.currentIndex == entry.key ? 20 : 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: cubit.currentIndex == entry.key
                          ? Colors.blue
                          : Colors.grey.withOpacity(0.5),
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        },
      ),
    );
  }
}