import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/app_colors.dart';
import '../../viewmodels/cubit/Bloc.dart';
import '../../viewmodels/cubit/states.dart';
import '../Wedget/carousel/CarouseSlider.dart';
import '../Wedget/category/CustomItemCategoryBar.dart';
import '../Wedget/buttons/SectionTitle.dart';
import '../Wedget/search/CustomSearchItem.dart';

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
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOutQuint,
                    height: 54,
                    margin: const EdgeInsets.only(top: 12),
                    decoration: BoxDecoration(
                      color: AppColors.searchBar,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: AppColors.border,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.notifications_none_rounded,
                              size: 28, color: AppColors.textPrimary),
                        ),
                        Expanded(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Container(
                              child: TextField(
                                onChanged: (value) {
                                  context
                                      .read<DalilyCubit>()
                                      .fetchAllCategoriesData(
                                    [
                                      "pharmacies",
                                      "Laboratories",
                                      "Pediatrics",
                                      "Dentistry",
                                      "Orthopedics",
                                      "Radiology",
                                      "Dermatology",
                                      "Cardiology",
                                      "Diabetes",
                                      "Physiotherapy",
                                      "Restaurants",
                                      "Cafes",
                                      "Grocery",
                                      "Herbal Shop",
                                      "Fruits and Vegetables",
                                      "Fried Food and Snacks",
                                      "Electronics",
                                      "Home Appliances",
                                      "Supplies and Paints",
                                      "Barbershops",
                                    ],
                                    query: value,
                                  );
                                },
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'ما الذي تبحث عنه؟',
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
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
