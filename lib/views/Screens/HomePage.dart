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
                  // شريط البحث المحسن
                  Container(
                    height: 54,
                    margin: const EdgeInsets.only(top: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        )
                      ],
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
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  prefixIcon: Icon(Icons.search, color: Colors.grey),
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

                  // قسم الخدمات الطبية مع تحسينات
                  SectionTitleWithIcon(
                      title: "الخدمات الطبية",
                      icon: Icons.medical_services
                  ),
                  const SizedBox(height: 10),
                  CategoryList(items: cubit.items),
                  const SizedBox(height: 18),

                  // قسم خدمات الطعام والتسوق
                  SectionTitleWithIcon(
                      title: "خدمات الطعام والتسوق",
                      icon: Icons.restaurant
                  ),
                  const SizedBox(height: 10),
                  CategoryList(items: cubit.items2),
                  const SizedBox(height: 18),

                  // قسم الخدمات العامة
                  SectionTitleWithIcon(
                      title: "الخدمات العامة",
                      icon: Icons.miscellaneous_services
                  ),
                  const SizedBox(height: 10),
                  CategoryList(items: cubit.items3),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}