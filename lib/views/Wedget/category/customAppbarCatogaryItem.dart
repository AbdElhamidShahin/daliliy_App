import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/app_colors.dart';
import '../../../viewmodels/cubit/Bloc.dart';
import '../../../viewmodels/cubit/states.dart' show DalilyState, CategoryLoaded;
import '../contact/buildCustomBackButton.dart';
import '../search/CustomSearchItem.dart';

class CustomAppbarCatogaryItem extends StatelessWidget {
  final String screenTitle;
  final String tableName;

  const CustomAppbarCatogaryItem({
    Key? key,
    required this.screenTitle,
    required this.tableName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient:const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.secondary,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Counter with animation
                  BlocBuilder<DalilyCubit, DalilyState>(
                    builder: (context, state) {
                      final count = (state is CategoryLoaded)
                          ? state.categories.length
                          : 0;
                      return TweenAnimationBuilder(
                        tween: IntTween(begin: 0, end: count),
                        duration: const Duration(milliseconds: 800),
                        builder: (context, value, child) {
                          return Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.purpleAccent.withOpacity(0.3),
                                  Colors.deepPurple.withOpacity(0.5),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(26),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.4),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.deepPurple.withOpacity(0.4),
                                  blurRadius: 15,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                '$value',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),

                  // Title
                  Hero(
                    tag: 'appbar-title',
                    child: Material(
                      color: Colors.transparent,
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                          shadows: [
                            Shadow(
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.2),
                            ),
                          ],
                        ),
                        child: Text(screenTitle),
                      ),
                    ),
                  ),

                  // Back button
                  buildCustomBackButton(context),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: CustomSearchBar(
                  onSearch: (query) {
                    context
                        .read<DalilyCubit>()
                        .fetchCategoryData(tableName, query: query);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
