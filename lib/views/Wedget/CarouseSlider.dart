import 'package:Tourism_app/models/cubit/Bloc.dart';
import 'package:Tourism_app/models/cubit/states.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomCarouseslider extends StatelessWidget {
  int _currentIndex = 0; // بداية من أول صورة

  CustomCarouseslider({super.key});

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
                            child: Image.network(url, fit: BoxFit.cover)),
                      );
                    },
                  );
                }).toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  onPageChanged: (index, reason) {
                    cubit.currentIndex = index; // تحديث المؤشر عند تغيير الصورة
                  },
                ),
              ),
              SizedBox(
                height: 25,
              ),
              CarouselIndicator(
                count: cubit.imageUrls.length,
                activeColor: Colors.blue, // اللون للنقاط النشطة
                color: Colors.grey, // اللون للنقاط الغير نشطة
                index: _currentIndex, // تم تمرير قيمة الـ currentIndex
              ),
            ],
          );
        },
      ),
    );
  }
}
