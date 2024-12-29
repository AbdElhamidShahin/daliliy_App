import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/Item.dart';
import '../../models/cubit/Bloc.dart';
import '../../models/cubit/states.dart';
import '../Wedget/CustomItemCatogry.dart';
import 'CustomDetailsScreen.dart';

class MedicalScreen extends StatelessWidget {
  final int? ItemCount;
  final String tableName; // اسم الجدول في قاعدة البيانات
  final Category? category;

  const MedicalScreen(
      {Key? key, this.ItemCount, required this.tableName, this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(238, 220, 250, 255),
      appBar: AppBar(
        title: const Text('Medical Screen'),
      ),
      body: Column(
        children: [
          // Header Section
          Container(
            height: 50,
            decoration: const BoxDecoration(color: Colors.blue),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Container(
                      height: 40,
                      width: screenWidth * 0.15,
                      decoration: const BoxDecoration(color: Colors.black12),
                      child: Center(
                        child: BlocBuilder<DalilyCubit, DalilyState>(
                          builder: (context, state) {
                            if (state is CategoryLoaded) {
                              final itemCount = state.categories.length;
                              return Text(
                                '$itemCount', // Display item count
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            } else {
                              return const CircularProgressIndicator(
                                color: Colors.white,
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    "صيداليات",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.06,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ListView Section
          Expanded(
            child: BlocBuilder<DalilyCubit, DalilyState>(
              builder: (context, state) {
                if (state is CategoryLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CategoryLoaded) {
                  final categories = state.categories;

                  return ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CustomDetailsScreen(
                                category: categories[
                                    index], // Passing selected category
                              ),
                            ),
                          );
                        },
                        child: CustomItemCatogry(
                          screenWidth: MediaQuery.of(context).size.width,
                          name: categories[index].name,
                          description: categories[index].description,
                          imageUrl: categories[index].imageUrl,
                        ),
                      );
                    },
                  );
                } else if (state is CategoryError) {
                  return Center(
                    child: Text('Error: ${state.message}'),
                  );
                } else {
                  return const Center(child: Text('No data available'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
