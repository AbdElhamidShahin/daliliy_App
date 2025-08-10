import 'package:flutter/material.dart';
import 'package:Tourism_app/core/constants/color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/Item/Item.dart';
import '../../models/cubit/Bloc.dart';
import '../../models/cubit/states.dart';
import '../Wedget/CustomItemCatogry.dart';
import '../Wedget/buildErrorWidget.dart';
import '../Wedget/customAppbarCatogaryItem.dart';
import '../Wedget/CustomSearchItem.dart';
import 'CustomDetailsScreen.dart';

class MedicalScreen extends StatelessWidget {
  final int? itemCount;
  final String tableName;
  final Category? category;
  final String screenTitle;

  const MedicalScreen({
    Key? key,
    this.itemCount,
    required this.tableName,
    this.category,
    required this.screenTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorV,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: CustomAppbarCatogaryItem(
          screenTitle: screenTitle,
          tableName: tableName,
        ),
      ),
      body: Expanded(
        child: BlocBuilder<DalilyCubit, DalilyState>(
          builder: (context, state) {
            if (state is CategoryLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CategoryLoaded) {
              final categories = state.categories;
              if (categories.isEmpty) {
                return const Center(child: Text('لا توجد نتائج'));
              }
              return ListView.builder(
                padding: const EdgeInsets.only(top: 8),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return CustomItemCategory(
                    category: categories[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CustomDetailsScreen(
                            category: categories[index],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            } else if (state is CategoryError) {
              return buildErrorWidget('تـأكد من الشبكه وحاول مره اخري');
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}
