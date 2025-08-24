import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/app_colors.dart';
import '../../viewmodels/cubit/Bloc.dart';
import '../../viewmodels/cubit/states.dart';
import '../Wedget/carousel/CarouseSlider.dart';
import '../Wedget/category/CustomItemCategoryBar.dart';

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
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16, right: 24, left: 0),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.notifications_none_rounded,
                            size: 28,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: AppColors.border.withOpacity(0.5),
                                width: 1,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                )
                              ],
                            ),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
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
                                  hintText: 'ابحث هنا...',
                                  hintStyle: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black45,
                                      fontWeight: FontWeight.w600),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                    size: 24,
                                  ),
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 12),
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
                  const SectionTitleWithIcon(
                      title: "الخدمات الطبية", icon: Icons.medical_services),
                  const SizedBox(height: 10),
                  CategoryList(items: cubit.items),
                  const SizedBox(height: 18),

                  // قسم خدمات الطعام والتسوق
                  const SectionTitleWithIcon(
                      title: "خدمات الطعام والتسوق", icon: Icons.restaurant),
                  const SizedBox(height: 10),
                  CategoryList(items: cubit.items2),
                  const SizedBox(height: 18),

                  // قسم الخدمات العامة
                  const SectionTitleWithIcon(
                      title: "الخدمات العامة",
                      icon: Icons.miscellaneous_services),
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

// عنصر جديد لعنوان القسم مع أيقونة
class SectionTitleWithIcon extends StatelessWidget {
  final String title;
  final IconData icon;

  const SectionTitleWithIcon(
      {super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(width: 8),
          Icon(icon, color: Colors.blue, size: 22),
        ],
      ),
    );
  }
}
