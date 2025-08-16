import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/app_colors.dart';
import '../../viewmodels/cubit/Bloc.dart';
import '../../viewmodels/cubit/states.dart';
import '../Wedget/carousel/CarouseSlider.dart';
import '../Wedget/category/CustomItemCategoryBar.dart';
import '../Wedget/buttons/SectionTitle.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DalilyCubit, DalilyState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var cubit = DalilyCubit.get(context);
        return Scaffold(
          backgroundColor: AppColors.background.withOpacity(0.98),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 12),
                  CustomCarouselSlider(),
                  const SizedBox(height: 20),
                  const SectionTitle(title: "الخدمات الطبية"),
                  const SizedBox(height: 10),
                  CategoryList(items: cubit.items),
                  const SizedBox(height: 18),
                  const SectionTitle(title: "خدمات الطعام والتسوق"),
                  const SizedBox(height: 10),
                  CategoryList(items: cubit.items2),
                  const SizedBox(height: 18),
                  const SectionTitle(title: "الخدمات العامة"),
                  const SizedBox(height: 10),
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
