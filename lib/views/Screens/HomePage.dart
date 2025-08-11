import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/app_colors.dart';
import '../../viewmodels/cubit/Bloc.dart';
import '../../viewmodels/cubit/states.dart';
import '../Wedget/carousel/CarouseSlider.dart';
import '../Wedget/category/CustomItemCategoryBar.dart';
import '../Wedget/search/CustomSearchItem.dart';
import '../Wedget/buttons/SectionTitle.dart';

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
