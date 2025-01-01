import 'package:Tourism_app/models/cubit/Bloc.dart';
import 'package:Tourism_app/models/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../views/Wedget/CarouseSlider.dart';
import '../views/Wedget/CustomItemCategoryBar.dart';
import '../views/Wedget/CustomSearchItem.dart';

class Wedget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DalilyCubit, DalilyState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var cubit = DalilyCubit.get(context);
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const CustomSearchItem(),
                  const SizedBox(height: 20),
                  CustomCarouseSlider(),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      ": خدمات طبيه",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: cubit.items2.map((item) {
                        return CustomItemCategoryBar(item: item);
                      }).toList(),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      ": خدمات الطعام والتسوق",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: cubit.items2.map((item) {
                        return CustomItemCategoryBar(item: item);
                      }).toList(),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      ": خدمات العامه ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: cubit.items3.map((item) {
                        return CustomItemCategoryBar(item: item);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
