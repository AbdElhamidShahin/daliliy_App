import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/cubit/Bloc.dart';
import '../../models/cubit/states.dart';
import '../Wedget/CustomItemCatogry.dart';

class MedicalScreen extends StatefulWidget {
  final int? index;

  const MedicalScreen({Key? key, this.index}) : super(key: key);

  @override
  State<MedicalScreen> createState() => _MedicalScreenState();
}

class _MedicalScreenState extends State<MedicalScreen> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<DalilyCubit>();
    if (cubit.state is! DalilyLoaded) {
      cubit.fetchData();
    }
  }

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
                            if (state is DalilyLoaded) {
                              int itemCount = state.data.length;
                              return Text(
                                "$itemCount", // عرض عدد العناصر
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
                if (state is DalilyLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                else if (state is DalilyError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.message),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<DalilyCubit>().fetchData();
                          },
                          child: const Text("Retry"),
                        ),
                      ],
                    ),
                  );
                } else if (state is DalilyLoaded) {
                  var data = state.data;
                  if (data.isEmpty) {
                    return const Center(
                      child: Text("No data available"),
                    );
                  }
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return CustomItemCatogry(
                        screenWidth: screenWidth,
                        name: data[index]['name']!,
                        description: data[index]['description']!,
                        imageUrl: data[index]['image_url']!,
                      );
                    },
                  );

                } else {
                  return const Center(child: Text("No data available"));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
