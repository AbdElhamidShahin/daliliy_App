import 'package:Tourism_app/models/cubit/Bloc.dart';
import 'package:Tourism_app/models/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../views/Wedget/CarouseSlider.dart';
import '../views/Wedget/CustomItemCatogry.dart';
import '../views/Wedget/CustomSearchItem.dart';

class Wedget extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return BlocConsumer<DalilyCubit,DalilyState>(
      listener: (BuildContext context,  state) {  },
      builder: (BuildContext context,  state) {
        var cubit = DalilyCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Customsearchitem(),
                const SizedBox(height: 20),
                CustomCarouseslider(),
                const Text(
                  ": خدمات طبيه",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: cubit.items.map((item) {
                      return CustomItemCategory(item: item);
                    }).toList(),
                  ),
                ),
                const Text(
                  ": خدمات اجتماعيه ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: cubit.items2.map((item) {
                      return CustomItemCategory(item: item);
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
