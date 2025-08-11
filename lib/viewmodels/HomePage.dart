import 'package:Tourism_app/models/cubit/Bloc.dart';
import 'package:Tourism_app/models/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Color.dart';
import '../views/Wedget/CarouseSlider.dart';
import '../views/Wedget/CustomItemCategoryBar.dart';
import '../views/Wedget/CustomSearchItem.dart';
import '../views/Wedget/SectionTitle.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DalilyCubit, DalilyState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var cubit = DalilyCubit.get(context);
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 24),
                  CustomCarouselSlider(),
                  const SectionTitle(title: "الخدمات الطبية"),
                  const SizedBox(height: 8),
                  CategoryList(items: cubit.items),
                  const SectionTitle(title: "خدمات الطعام والتسوق"),
                  const SizedBox(height: 8),
                  CategoryList(items: cubit.items2),
                  const SectionTitle(title: "الخدمات العامة"),
                  const SizedBox(height: 8),
                  CategoryList(items: cubit.items3),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
